Date: Tue, 10 Sep 2002 09:54:58 +0100 (BST)
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Stephan Linke <Stephan.Linke@epygi.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FW: 860 ATM - channel deactivation
In-Reply-To: <FCEAKDJJAPHPLJFINDAJOELCCIAA.Stephan.Linke@epygi.de>
Message-ID: <Pine.LNX.4.44.0209100944500.16356-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 9 Sep 2002, Stephan Linke wrote:


Thanks, Stephan, for pointing this out.  I think you're right.  I've also
noticed that mpc860sar_undo_activate_channel() is not disabling
receptions in the CPM - which might be necessary if mpc860sar_activate_channel()
successfully set up rx but failed on setting up tx.

I will change mpc860sar_undo_activate_channel() so that the 1st thing it
does is:

	if(chan->initialised) /* rx enabled in CPM */
		mpc860sar_rx_channel(chan->dev, CPM_CHAN_DISABLE, chan);

and the 2nd thing it does is to delete the address mapping.

I'll get round to putting this on sourceforge CVS
(CVSROOT=yourname@cvs.mpc860sar.sourceforge.net:/cvsroot/mpc860sar)
sometime today.  I'll write to you when it's done.

Alex

>
> Hi,
>
> I had a look at the sources of mpc860sar. In mpc860sar.c there is the
> mpc860sar_undo_activate_channel() function that deactivates a channel (ATM
> VCC) and releases the resources.
> I'm curious about the fact that the deactivation of the channel by calling
> mpc860sar_del_address_mapping() is performed after all the ressources where
> released. Shouldn't it all be done exactly the opposite way arround?
> In case the order is wrong no one will notice it as long as there's no
> traffic arriving while this function is running. And I didn't had any
> trouble so far too. But I'm shure it is wrong.
>
> Could anyone check this? (I hope I'm in the right mailing list. :))
>
> Thanks, Stephan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
