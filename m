Message-ID: <37B92306.A8377B94@lip6.fr>
Date: Tue, 17 Aug 1999 10:53:26 +0200
From: Anthony Lester <Anthony.Lester@lip6.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: gnome-ppp and the mac serial ports
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've finally got gnome-ppp working after commenting out a section of the source code which
checks the DCD (Data Carrier Detect) line of the serial port. The kernel code
corresponding to this check is in the file "macserial.c" and sets various bits of a status
byte according to the value of a register in the zilog uart which handles the standard mac
serial ports.

However the standard RS422 mac ports only have handsake-in and handshake-out lines
(corresponding to RTS and DTR for the RS232 I think) so there is no line corresponding to
DCD. So how would it get DCD?

The most surprising thing is that the kernel source contains explicit treatment for DCD,
so unless I am very much mistaken (or I have a dodgy modem cable) there is something
strange.

Any comments, what should be modified, applications, kernel, or both?

Anthony

--      _            ---------------------------------------
       (_)          |                     Anthony LESTER    |
    _   _   ___     |    Coul. 65-55,  2e etg,  Bur. 230    |
   | | | | |   )    |    UPMC  /  LIP6  /  ASIM  /  CNRS    |
   | | | | | 6  )   |    4 pl Jussieu, 75252 PARIS cdx 5    |
   | | |_| |  _)    |                                       |
   | |___  | |      |    Tel: +33 1 4427 7124 (fax 7280)    |
   |_____| |_|      |       http://www-asim.lip6.fr/        |

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
