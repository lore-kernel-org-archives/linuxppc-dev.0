Return-Path: <michael@ellerman.id.au>
Date: Fri, 12 Jul 2013 11:21:43 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Chris Friesen <cbf123@mail.usask.ca>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
Message-ID: <20130712012142.GA24112@concordia>
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51DF2229.5010604@mail.usask.ca>
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 11, 2013 at 03:22:49PM -0600, Chris Friesen wrote:
> On 07/11/2013 02:55 PM, Chris Friesen wrote:
> >Hi,
> >
> >I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
> >with 8GB of memory.  (It's an embedded system and I can't do much
> >about the fact that it's using older software.)
> 
> I should probably clarify this...I may be able to update kexec, I
> can't update the kernel but I can backport more recent code if
> necessary.
> 
> Looking at the version of kexec that I have, it seems like where x86
> uses "memmap=" to specify the memory map usable by the capture
> kernel, powerpc does something different.

>From memory, it's been years, on powerpc we add properties to the memory
nodes in the device tree that specify which memory is usable. The
properties are called "linux,usable-memory", and in modern kernels they
are read in early_init_dt_scan_memory().

cheers
