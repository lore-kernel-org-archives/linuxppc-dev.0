MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Poor 8260 FCC Ethernet performance 
Date: Mon, 7 Jun 2004 11:33:04 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB09226B@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Adisorn
> Ermongkonchai
> Sent: Monday, June 07, 2004 1:21 PM
> To: Mark Chambers
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Poor 8260 FCC Ethernet performance
>
>
>
> --- Mark Chambers <markc@mail.com> wrote:
> > Hi Adisorn,
> >
> > You should probably try monitoring your network with
> > Ethereal or something
> > similar to see what the problem really is - in other
> > words make sure that
> > the problem really is packets coming out of your
> > board too slowly.
> >
> > Mark Chambers
> >
> It is the packet coming out from the board that is
> slow.  But we also found that receiving side is
> even slower.  What was the 8260 FCC performance that
> you got?  According to Dean's response, he could
> forward at 29000 pps and that was much, much
> better than ours.
>
> Adisorn.
>

Hi Adisorn:

Did you check your settings in the FCC Ethernet Mode Register (FPSMR) bits 3 Local Protect Bit (LPB) and 5 Full Duplex Ethernet (FDE)?  In particular, LPB and FDE _MUST_ be set to '1' in full duplex.  This has been a problem in the past with FCC ethernet drivers, including the linux driver.

1) If you have a miss-match on full/half duplex between your switch/hub and/or your PHY and/or your FCC, you will have very poor ethernet performance, very similar to what you are complaining about.  Your Rx may be delayed/suppressed by Tx packets, or you may see lots of late collisions.

2) Another hint I haven't experienced personally (yet :-) is that, if the board has layout problems between the PHY and the 8260, you can get a lot of CRC errors due to noise messing up your transmissions.  I'm guessing that your problem is #1, however.

Question: What is your system setup?
  Hub or switch?
  PHY configuration is full/half? 10/100?
  FCC configuration is full/half, LPB = ? FDE = ?
  Do you see a lot of late collisions in the FCC registers?
  Do you see a lot of CRC failures?

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
