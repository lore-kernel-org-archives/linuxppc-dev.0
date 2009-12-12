Return-Path: <albert_herranz@yahoo.es>
Received: from smtp129.mail.ukl.yahoo.com (smtp129.mail.ukl.yahoo.com
	[77.238.184.60]) by ozlabs.org (Postfix) with SMTP id CE9CAB7B93
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 11:33:13 +1100 (EST)
Message-ID: <4B22E4CB.2040509@yahoo.es>
Date: Sat, 12 Dec 2009 01:33:15 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: allow ioremap within reserved memory
	regions
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>	
	<1260297833-17625-4-git-send-email-albert_herranz@yahoo.es>
	<1260569600.16132.375.camel@pasglop>
In-Reply-To: <1260569600.16132.375.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-08 at 19:43 +0100, Albert Herranz wrote:
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>> ---
>> v1 -> v2
>> - use a run-time flag to allow/disallow remapping reserved regions
>> - use lmbs to determine reserved regions
> 
> We won't need that once we fix proper discontig mem.
> 
> BTW. Question: Why do we need that fixup of yours to fold the 2 LMBs
> into one ?
> 
> Wouldn't it be easier just to keep the 2 LMBs ? You already fix the
> mapin_ram thingy, so you could easily fix it up to just iterate over the
> LMBs instead no ? For now, it could only BAT map the first LMB to
> simplify things and we can fix the BAT mapping for the second one in a
> second step too.
> 
> Wouldn't that work with simpler code ? An in the case of ioremap, the
> test becomes simply to check if it's RAM by checking if it's in the LMB
> rather than if it's reserved, which should be easier and wouldn't
> require your flag to "enable" the tweak since it could perfectly be kept
> as standard behaviour
> 
> Also the code in arch/powerpc/mm/mem.c will already deal with holes
> just fine and will pass the hole size information to the VM which should
> make it behave properly.
> 
> Thus I have the feeling that keeping the 2 LMBs rather than coalescing
> would simplify the code basically by only requiring a small fixup of the
> maping RAM bit.
> 
> I'm acking the patches for now, so you can always come up with a fixup
> on top of them and we can merge the current ones.
> 

I'll look into this.
I used a single lmb range just as the current code does to avoid any unwanted side effects as I didn't audit all the mm code.

Thanks,
Albert
