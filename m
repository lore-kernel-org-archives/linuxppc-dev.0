Return-Path: <mpe@ellerman.id.au>
Message-ID: <1427698456.28219.2.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/powernv: convert codes returned by OPAL
 calls
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Mon, 30 Mar 2015 17:54:16 +1100
In-Reply-To: <5518EF16.9070502@fr.ibm.com>
References: <20150327095936.50A921400A0@ozlabs.org>
 <1427474362-3903-1-git-send-email-clg@fr.ibm.com>
 <1427681112.4218.6.camel@ellerman.id.au> <5518EF16.9070502@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 08:37 +0200, Cedric Le Goater wrote:
> On 03/30/2015 04:05 AM, Michael Ellerman wrote:
> > On Fri, 2015-03-27 at 17:39 +0100, Cédric Le Goater wrote:
> >> OPAL has its own list of return codes. The patch provides a translation
> >> of such codes in errnos for the opal_sensor_read call, and possibly 
> >> others if needed.
> >>
> >> +	case OPAL_UNSUPPORTED:		return -ENOSYS;
> > 
> > You shouldn't use ENOSYS here, that should only ever mean "no such syscall",
> > otherwise you get very confusing results like read() returning ENOSYS.
> 
> Indeed. How about ENODEV then ? 

That can also be confusing from userspace.

I think it's probably best just to use EIO, as far as userspace is concerned if
the kernel lets it call an unsupported OPAL routine that is more or less a
kernel bug.

cheers
