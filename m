Message-ID: <000d01c1bffd$6ce5dfc0$0c1112ac@ming>
From: "Chen Yaoming" <ymchen@ocdtt.com>
To: "Rodolfo Giometti" <giometti@linux.it>,
	<new-software@lists-linuxppc.org>
Cc: <paulus@samba.org>, <khc@pm.waw.pl>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20020227150024.D596@morgana.systemy.it>
Subject: Re: HDLC/Frame Relay support for MPC8xx
Date: Thu, 28 Feb 2002 10:12:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that there were many changes to the generic HDLC layer and
the network core files. Are these changes necessary to run CPM HDLC?

----- Original Message -----
From: "Rodolfo Giometti" <giometti@linux.it>
To: <new-software@lists-linuxppc.org>
Cc: <paulus@samba.org>; <khc@pm.waw.pl>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, February 27, 2002 10:00 PM
Subject: HDLC/Frame Relay support for MPC8xx


>
> Hello,
>
> I developed a driver to support the HDLC/Frame Relay transmission for
> the MPC8xx/FADS. Currently the driver supports only the asynchronous
> mode but, as soon as I have the proper hardware, I'll add the
> synchronous mode too.
>
> I posted my software hoping that it can be useful and hoping someone
> will test and improve it! ;-p
>
> Since my developing board is not the final product where the software
> will work some features are actually not tested or not fully
> implemented.
>
> Please, feel free to write me back for any suggestions or
> modifications.
>
> This software is a part of a bigger project by Ascensit
> <http://www.ascensit.com> to expand the current CPM support in
> Linux. Our next steps will be:
>
> * Add a better CPM subsystems support by adding a set of
>   register/unregister functions and by adding a proc-filesystem support
>   to track down who are using what.
>
> * Add the synchronous HDLC support.
>
> * Add support for other CPM subsystems like, for istance the I2C and
>   so on.
>
> * Other minor featurs in order to stabilize the CPM support.
>
> INSTALL
> =======
>
> In order to have a working code I took a patched linux-2.4.17 from my
> (great) colleague Christian Pellegrin who applied some patched from
> denx and modified some code by himself.
>
> Here the patch from vanilla linux-2.4.17 to linux-2.4.17-fads in order
> to have a running code for the FADS developing board.
>
> Warning! it is possible that this patch adds some extra unneeded code
> since nor me nor Christian are able to find the patches that we used
> to obtain the working code for the FADS... sorry! That was our fault!
>
> Obviously if you already have a running kernel for the FADS you don't
> need to apply this patch.
>
>    http://www.ascensit.com/developers/ehdlc/patch-linux-2.4.17-fads.gz
>
> Here the patch from linux-2.4.17-fads to linux-2.4.17-fads-fr in order
> to have the right Frame Relay support.
>
>    http://www.ascensit.com/developers/ehdlc/hdlc-2.5.1.patch.gz
>    http://www.ascensit.com/developers/ehdlc/hdlc-S0.gz
>
> Here the patch from linux-2.4.17-fads-fr to linux-2.4.17-fads-fr-ehdlc
> in order to have my code! :-D
>
> Please note that my patch doesn't modify the new Frame Relay support
> provided by the above patch.
>
>
http://www.ascensit.com/developers/ehdlc/patch-linux-2.4.17-fads-fr-ehdlc.gz
>
> Obviously you have to apply the above patches in the same order as I
> explained.
>
> MY TESTS
> ========
>
> The tests I made on my code were divided in two parts: one in order to
> test asynchronous HDLC and one to test Frame Relay on asynchronous
> HDLC.
>
> I used only three wires in order to connect my two FADS each other,
> and more precisely I used the PINS B2, B3 and B32 of the expansion
> connector. Since I used only the TXD and RXD signals I didn't check
> the options "CTS and CD input enabled" in order to have "CTS and CD
> always asserted". Currently the driver uses only the SCC3.
>
> In order to configure the HDLC subsystem I used the sethdlc program
> version 1.08 (you can find that program on
> http://www.ascensit.com/developers/ehdlc/sethdlc.c.gz).
>
> Regarding the asynchronous HDLC test I used the following commands:
>
>    /sbin/insmod /lib/modules/2.4.17/kernel/drivers/net/wan/syncppp.o
>    /sbin/insmod /lib/modules/2.4.17/kernel/drivers/net/wan/hdlc.o
>    /sbin/insmod /lib/modules/2.4.17/kernel/arch/ppc/8xx_io/ehdlc.o
>    /sbin/sethdlc hdlc0 clock int rate 64000
>
>    /sbin/sethdlc hdlc0 hdlc nrz no-parity
>    /sbin/ifconfig hdlc0 192.168.1.1 pointopoint 192.168.1.2
>       /sbin/ifconfig hdlc0 192.168.1.2 pointopoint 192.168.1.1   [on the
other machine]
>
> Then I used the normal ping command.
>
> Regarding the Frame Relay (on asynchronous HDLC) I used the following
> commands:
>
>    /sbin/insmod /lib/modules/2.4.17/kernel/drivers/net/wan/syncppp.o
>    /sbin/insmod /lib/modules/2.4.17/kernel/drivers/net/wan/hdlc.o
>    /sbin/insmod /lib/modules/2.4.17/kernel/arch/ppc/8xx_io/ehdlc.o
>    /sbin/sethdlc hdlc0 clock int rate 64000
>
>    /sbin/sethdlc hdlc0 fr lmi ansi
>       /sbin/sethdlc hdlc0 fr lmi ansi dce   [on the DCE]
>    /sbin/sethdlc hdlc0 create 666
>    /sbin/ifconfig hdlc0 up
>    /sbin/ifconfig pvc0 192.168.1.1 pointopoint 192.168.1.2
>       /sbin/ifconfig pvc0 192.168.1.2 pointopoint 192.168.1.1   [on the
other machine]
>
> Enjoy! :-D
>
> Rodolfo
>
> --
> Programs and GNU solutions           e-mail:    giometti@linux.it
> Linux Device Driver                             giometti@ascensit.com
> Embedded Systems                     home page: giometti.oltrelinux.com
> UNIX programming                     phone:     +39 329 7028903
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
