Date: Wed, 21 Apr 1999 10:30:40 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New boot attempts on a MVME2431 
In-Reply-To: <371B741C.35603A35@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990421101949.20020T-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 19 Apr 1999, Simone Piccardi wrote:

> 
> Hi,
> 
> I'm still trying to boot LinucPPC on this board. Thanks to new kernel
> images provided by G. Paubert in his site I could obtain some new
> results (not a success but at least this time the boot is going a bit
> further).


Ok, what does the SROM command under PPCBug return. There is a bug in the
setup of these.

You have to type SROM, answer Y to the first question and list all the
values until the the address 0x80. Then around address 0x20, there is
probably a byte which is 0x08 and should be 0x00, but I can't tell you the
exact address without the dump.

> It seems quite strange to me also the message:
> OpenPIC Version ? (2 CPUs and 17 IRQ sources) at d1000000
> Why 2 CPU?

Because the OpenPIC in the Raven and Hawk support up to 2 CPUs. This does
not mean that they are installed however...

> time_init: decrementer frequency = 998700000/60 (15MHz)

This is strange, it should be 25 MHz. I have got timing problems on my
board too... Going to investigate since it seems constant when it should
not.


> My question are: 
> Is the way I gave the boot parameter (root=/dev/nfs) right? 
> I exported an empty /home/ppc directory on the same PC that I used as 
> tftp server, but how the board can recognize just this directory? And 
> what files I have to put in this directory?

You have to setup you /etc/bootptab entries and /etc/exports. Don't forget 
to set the export as no_root_squash.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
