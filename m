Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Subject: Re: LXT972 FEC problem on MPC855
Date: Mon, 26 Aug 2002 19:34:24 -0300
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20020826182707.BA14B11829@denx.denx.de> <3D6A9E57.1060308@redswitch.com>
In-Reply-To: <3D6A9E57.1060308@redswitch.com>
MIME-Version: 1.0
Message-Id: <02082619342400.01116@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shawn:

Maybe I have a contribution...

On Monday 26 August 2002 18:32, Xiaogeng (Shawn) Jin wrote:
> > You are passing bad/insufficient boot arguments to the Linux  kernel;
> > unfortunaltely you don;t show us this part of the boot messages, so I
> > cannot even guess what you're doing wrong.
>
> Finally I figured out the problem and solved it. The problem is that the
> kernel didn't get the LINK status correctly. The 'fep->link' was always
> 0 which means the link is down or autonegotiation is in progress.
>
> In the code which defines 'phy_info_lxt971', it says that somehow LXT971
> tells me that the link is down when the first read after power-up. So
> you have to read MII_REG_SR to set 'fep->phy_status' accordingly. But in
> my case, the read action occurred too early to wait till the link is up.
> So what I did is to delay 5s before reading MII_REG_SR during opening
> FEC device. I guess it takes the link a while to autonegotiate the speed.

Hmm. I suppose PHY should interrupt when link status change, and therefore
phy_status would be updated accordingly. So, maybe you have a problem with
your board's PHY interrupt signal.

Hope this helps.

-Scop.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
