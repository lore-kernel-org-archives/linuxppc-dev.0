From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15755.43019.561962.41394@argo.ozlabs.ibm.com>
Date: Sat, 21 Sep 2002 08:58:19 +1000 (EST)
To: nbasker@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: data address causing machine check exception
In-Reply-To: <1032528899.3d8b2403648a5@pop-mail.india.tejasnetworks.com>
References: <20020919170814.E25F9FA8E@denx.denx.de>
	<1032528899.3d8b2403648a5@pop-mail.india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


nbasker@india.tejasnetworks.com writes:

> In the sample crash I had sent in the previous mail (attached below),
> I deliberately caused a crash by accessing an invalid address
> 0xfd040000 which is in gpr[3], the first parameter to a
> function that caused the crash.
>
> But this invalid address is not in DAR or SRR0 as I expected,
> instead I found the following;
> srr0 = c0017f70 srr1 = 00001032 dar = 00000000 dsisr = 00000000.
>
> Is it not gauranteed that DAR will have invalid address.
>
>  Machine check in kernel mode.

What happened is that the address you accessed *was* mapped, but it
was mapped to an invalid physical address.  Under these circumstances
the processor assumes that the address is OK, since there is a mapping
for it, and proceeds to do other work while the memory subsystem is
fetching and returning the data.  When the memory subsystem says "I
don't know anything about that physical address", the processor takes
a machine check (0x200) exception.  The DAR is not set for a machine
check exception, since a machine check exception can happen for a
variety of reasons, and there could be several loads or stores
outstanding, so there is no way in general to know which particular
load or store caused the error.

If you try accessing an address which isn't mapped, you will get a
data access exception (0x300) and the DAR will contain the address you
tried to access.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
