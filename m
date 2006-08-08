Return-Path: <haren@us.ibm.com>
Message-ID: <44D8230F.4020202@us.ibm.com>
Date: Mon, 07 Aug 2006 22:37:19 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] consolidated libdt proposal
References: <20060719230544.GD3887@mag.az.mvista.com>	
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
In-Reply-To: <1154987921.24455.32.camel@basalt.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Pantelis Antoniou <pantelis@embeddedalley.com>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:

>On Sun, 2006-08-06 at 19:38 -0500, Hollis Blanchard wrote:
>  
>
>>Hmm, so we'll have at least three copies of this code: uboot, kernel,
>>and Xen. Would it make sense to put this stuff into a libdt.a?
>>Technically, dtc has a "libdt" already, but it's absurdly incomplete
>>(I don't even know why it's there), so we could just replace it. 
>>    
>>
>
>Mark, I had a look at the code Pantelis wrote for u-boot, and it was
>pretty easy to adapt to meet Xen's (userspace-based) needs. I've
>attached my version below (and see ft_setup() at the bottom of the
>file). Does it meet your requirements for the kernel bootwrapper?
>
>One limitation of the attached code is that it doesn't support changing
>the *size* of properties, though I don't think that would be too
>difficult to add if needed.
>
>Haren, what about using this in kexec-tools?
>

Hollis,
    Good idea to have this lib. Based on brief look, some of these funcs 
are also useful for kexec-tools. Yes, as you mentioned, changing the 
size of properties is important for kexec/kdump.

Present flattened device-tree process in kexec-tools:

- Kexec-tool reads the /proc/device-tree and sort these entries since we 
get the different order than the first kernel uses.
- creates linux,usable-memory property under /proc/device-tree/memory@* 
as appropriate.  (for kdump)
- Modify the reserve map for RTAS, initrd, TCE and (0- crashkernel-start)
- Create initrd properties if not exist in the first kernel as needed
- Modify bootargs property

Thanks
Haren

>If everybody can use this (I expect small modifications would be
>needed), I think we should turn it into a library in the dtc source
>tree. The various projects using it could then include snapshots (to
>avoid dependencies). In general I'd like to avoid everybody writing and
>maintaining their own version of this stuff (myself included).
>
>  
>
>------------------------------------------------------------------------
>
>/
>
