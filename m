Message-ID: <3E18120C.7030906@tataelxsi.co.in>
Date: Sun, 05 Jan 2003 16:37:56 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mcc in mpc8260.
References: <3E1705CD.2090506@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am posting the answer I found out for my problem. This may help
somebody sometime :-)

Scenariao:
An octal framer is interfaced with mpc8260. output of the framer is
E1/T1 channels in HDLC.

Problem :
The application uses 8 device entries to pump and receive the data into
and out of each framer. Each E1/T1 line should go to one /dev/e1t1_0
through /dev/e1t1_7.
MCC does the channelization of the data. So it would require 256
/dev/e1t1_x entries. How to avoid this and multiplex the data into 8
device files?

The solution I found is:
On the Rx side:
Program the SIxRam entries to channelize 32 (24) virtual channels of
64kbps each on the E1 (T1). so the resulting data will flow to one MCC
channel (say channel 0,32,64 and 96 on MCC1 and 128,160,192 and 224 on
MCC2). These can be respectively mapped into 4 Rx queues and the BD data
can be copied into one /dev/e1t1_x. In this case there will only 8 MCC
channels being used.

On the Tx Side:
Create superchannels.
One Tx superchannel will comprise of 32 Time Slots( MCC virtual
channels). Each of the entry in this SCTable will point to channel x
(say in SCT x will be 0 for first 32 virtual channels, 32 for 32-63
virtual channels, 64 for 64 through 96 and so on).
By this approach, whenever there is data in VC 0, it will get equally
destributed to 0-31 vitrual channels (MCC channels) and so on and so forth.

I hope this approach is OK. If you have any suggestions , please mail me
either offlist or on list.

Thank you for your patience,
Om.

Omanakuttan wrote:
>
> Hi,
> We are using mcp8260 interfaced with an octal E1/T1 framer (XRT84L38).
> We are using 7 E1/T1 lines as input for the MCC is from the framer.
>
> How does the MCC HDLC controller treat the incoming E1/T1 frames? will
> the HDLC controller will treat each E1 line as 32 different logical
> channels and interrupt when one HDLC frame (per logical channel) is
> received? If it is not so, how can I get the HDLC frames? Will it fill
> in one TDM channel (first in each group 0,32,64,96..etc) ?
>
> I went through the example code given in the motorola website. But they
> do not really address this problem.
>
> Thanks and regards,
> Om
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
