Return-Path: <hofrat@osadl.at>
Received: from mail.osadl.at (mail.osadl.at [92.243.35.153])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sLB1y2Yz3zDrcM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 16:28:22 +1000 (AEST)
Date: Fri, 26 Aug 2016 06:21:27 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next@vger.kernel.org, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kbuild@vger.kernel.org
Subject: Re: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20160826062127.GA13930@osadl.at>
References: <20160817114443.67675413@canb.auug.org.au>
 <e6fbe17c-1981-1579-433d-88462d2efb58@suse.cz>
 <20160818110948.52f1322d@roar.ozlabs.ibm.com>
 <20160819133854.17a7b1ca@canb.auug.org.au>
 <20160819150914.36106b5b@canb.auug.org.au>
 <5babe9ef-0e3d-6975-9ba4-9a29a700b24d@suse.cz>
 <20160819204455.6351ffb8@roar.ozlabs.ibm.com>
 <20160822204758.5b2cff63@roar.ozlabs.ibm.com>
 <20160826135803.0c5ffb42@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160826135803.0c5ffb42@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2016 at 01:58:03PM +1000, Nicholas Piggin wrote:
> On Mon, 22 Aug 2016 20:47:58 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > On Fri, 19 Aug 2016 20:44:55 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> > 
> > > On Fri, 19 Aug 2016 10:37:00 +0200
> > > Michal Marek <mmarek@suse.cz> wrote:
> > >   
> > > > On 2016-08-19 07:09, Stephen Rothwell wrote:    
> > 
> > [snip]
> > 
> > > > > 
> > > > > I may be missing something, but genksyms generates the crc's off the
> > > > > preprocessed C source code and we don't have any for the asm files ...      
> > > > 
> > > > Of course you are right. Which means that we are losing type information
> > > > for these exports for CONFIG_MODVERSIONS purposes. I guess it's
> > > > acceptable, since the asm functions are pretty basic and their
> > > > signatures do not change.    
> > > 
> > > I don't completely agree. It would be nice to have the functionality
> > > still there.
> > > 
> > > What happens if you just run cmd_modversions on the as rule? It relies on
> > > !defined(__ASSEMBLY__), but we're feeding the result to genksyms, not as.
> > > It would require the header be included in the .S file and be protected for
> > > asm builds.  
> > 
> > 
> > This seems like it *could* be made to work, but there's a few problems.
> > 
> > - .h files are not made for C consumption. Matter of manually adding the
> > ifdef guards, which isn't terrible.
> > 
> > - .S files do not all include their .h where the C declaration is. Also
> > will cause some churn but doable and maybe not completely unreasonable.
> > 
> > - genksyms parser barfs when it hits the assembly of the .S file. Best
> > way to fix that seems just send the #include and EXPORT_SYMBOL lines
> > from the .S to the preprocessor. That's a bit of a rabbit hole too, with
> > some .S files being included, etc.
> > 
> > I'm not sure what to do here. If nobody cares and we lose CRCs for .S
> > exports, then okay we can whitelist those relocs easily. If we don't want
> > to lose the functionality, the above might work but it's a bit intrusive
> > an is going to require another cycle of prep patches to go through arch
> > code first.
> > 
> > Or suggestions for alternative approach?
> 
> Here is a quick patch that I think should catch missing CRCs in
> architecture independent way. If we merge something like this, we
> can whitelist the symbols in arch/powerpc so people get steered to
> the right place.
> 
> Powerpc seems to be the only one really catching this, and it's
> only as a side effect of a test run for CONFIG_RELOCATABLE kernels,
> which means version failures probably slipped through other archs.
> 
> I'll clean it up, do some more testing, and submit it unless
> anybody dislikes it or has a better way to do it.
> 
> Thanks,
> Nick
> 
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 4b8ffd3..1efc454 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -609,6 +609,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>  {
>  	unsigned int crc;
>  	enum export export;
> +	int is_crc = 0;

should that not be a bool here ?

>  
>  	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
>  	    strncmp(symname, "__ksymtab", 9) == 0)
> @@ -618,6 +619,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>  
>  	/* CRC'd symbol */
>  	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
> +		is_crc = 1;

is_crc = true;

>  		crc = (unsigned int) sym->st_value;
>  		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
>  				export);

thx!
hofrat
