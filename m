Date: Tue, 7 Mar 2000 10:51:57 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Rob Grimm <rgrimm@rtdsp.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded PowerPC750 problem: Kernel slow response from console
In-Reply-To: <005101bf87cc$cc3b26d0$1dc9a4cd@rtdsp.com>
Message-ID: <Pine.HPX.4.10.10003071044220.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Mon, 6 Mar 2000, Rob Grimm wrote:

>
> Hello All,
>     We are working on porting linux to an embedded platform based off of the
> PowerPC750.
> We are using Linux-2.2.13 configured for serial port console (there is a
> standard 16550 onboard).  So far, the kernel
> appears to boot fine (with networking disabled).  After we get the message
> about freeing kernel
> memory, it takes about 10 seconds for the bash# prompt to appear.  Once we
> get to this
> point, it seems like the kernel runs extremely slow.  When we type a letter,
> it takes about 10
> seconds for the letter to show up on the console ouput.

It happened to me in some versions of the kernel (2.3.45) since I use a
serial console in most configurations, the problem was indeed the
interrupt controller which was not initialized. It depends on your HW
however, in my case it was a typo which prevented using the 8259 when
cascaded with an OpenPIC. I mentioned it on the linuxppc-dev list and Cort
corrected the typo. It actually appeared in official 2.3.47 or so (I don't
remember exactly since I'm still at 2.3.45, I'm going to check soon
if 2.3.49 wants to work again with nfsroot).

>     I believe it has something to do with the interrupt controller (which we
> do not have setup correctly yet).

Which kind of interrupt controller do you have ?

> I have tried both disabling and enabling external interrupts, and get the
> same results.  Has anyone
> experienced similar problems?  We started off with the kernel configured for
> a Prep system
> (we later found out that our system is not much like the prep system), and
> went
> from there.  How does the kernel handle the serial console input if the
> interrupt is disabled?  It appears

I actually use the CHRP/PreP/PMAC option, and the bootloader reprograms
the host bridge (Motorola ravn or Hawk) from PreP to CHRP like mapping.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
