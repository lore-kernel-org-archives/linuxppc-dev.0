Message-ID: <369BC9D6.205B4494@jlc.net>
Date: Tue, 12 Jan 1999 17:16:54 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: RTHEANDE <rtheande@dscc.dk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PHY driver for 860T
References: <9901129161.AA916142427@smtplink.dscc.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


RTHEANDE wrote:

>      Hi there,
>
>      I'm building a board with an MPC860T that's supposed to run LinuxPPC.

No problem.  I do it every day :-).


> ....... This board should have a 100baseTX PHY chip from
>      Level One. If the above information is correct, could someone please
>      take a look and tell me which chip they use.

I did the original development of the FEC driver on the 860T FADS board.
I uses the Level One LTX970 part.

I have another board in hand right now that uses the Quality Semiconductor
QS6612 part.  I'll have the driver ready pretty soon.

This increases the complexity of the MII functions in the current FEC
driver.  I will probably use the de4x5.c as a model.  We now have to
determine which PHY is used and program accordingly.  The driver
currently does not support multiply PHYs, and I don't intend to do
the modification until I have such a configuration.  There is currently
and assumption the PHY address is known and fixed (by default it
is device 0).

I have tested this driver with both 10 and 100 Mbit networks, however
I have not found a full duplex 100 Mbit for testing.  The FEC needs to
be reprogrammed when this is detected.



    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
