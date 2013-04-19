Return-Path: <michael@ellerman.id.au>
Message-ID: <1366356021.5684.3.camel@concordia>
Subject: Re: [RFC PATCH powerpc] make CONFIG_NUMA depends on CONFIG_SMP
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2013 17:20:21 +1000
In-Reply-To: <1366337453.3250.16.camel@ThinkPad-T5421.cn.ibm.com>
References: <1338370318.3637.12.camel@ThinkPad-T420>
 <20130418014559.GB8261@concordia>
 <1366337453.3250.16.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-19 at 10:10 +0800, Li Zhong wrote:
> On Thu, 2013-04-18 at 11:46 +1000, Michael Ellerman wrote:
> > On Wed, May 30, 2012 at 05:31:58PM +0800, Li Zhong wrote:
> > > I'm not sure whether it makes sense to add this dependency to avoid
> > > CONFI_NUMA && !CONFIG_SMP. 
> > > 
> > > I want to do this because I saw some build errors on next-tree when
> > > compiling with CONFIG_SMP disabled, and it seems they are caused by some
> > > codes under the CONFIG_NUMA #ifdefs.  
> > 
> > This seems to make sense to me. Can you please repost with a better
> > changelog and a description of the actual build error you were seeing.
> 
> I tried it today, but didn't find any build errors any more, guess those
> errors should have already been fixed. 
> 
> But it seems to me by disabling CONFIG_NUMA when CONFIG_SMP is disabled,
> could at least prevent some unnecessary code being compiled into the
> kernel. (After building a kernel with/without CONFIG_NUMA just now, it
> seems that the vmlinux is ~100K smaller without CONFIG_NUMA).
> 
> I'm not sure whether this is still needed. 

Yeah we'll leave your patch out. Unless someone cares deeply about the
size of the UP build, I think it's better to just leave them as separate
options.

cheers
