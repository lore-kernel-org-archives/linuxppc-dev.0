Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp1.smiths.com (smtp1.smiths.com [192.208.34.50])
	by ozlabs.org (Postfix) with ESMTP id 7C23C2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 01:48:41 +1100 (EST)
Received: from COSSMGIMS04.email.corp.tld (unknown [10.225.225.147])
	by smtp1.smiths.com (Postfix) with ESMTP id 7A6281C00965
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 07:48:28 -0700 (MST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 5 Nov 2004 07:48:24 -0700
Message-ID: <065ACD8E84315E4394C835E398C8D5EB9E97EB@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Handling power failure - MPC5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=0D
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=0D
> J=F3n Benediktsson
> Sent: Friday, November 05, 2004 9:14 AM
> To: Wolfgang Denk
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Handling power failure - MPC5200
>=0D
> > In message <OF368071C2.FBC6B7BC-ON00256F42.003F3DF3-00256F42.
> > 0044E8BB@marel.is> you wrote:
> > >=0D
> > > Capacitors on the supply provide me with some=0D
> milliseconds to repond
> to=0D
> > > power failure, which I would
> > > like to use to do as much cleanup as possible before power is=0D
> > > totally gone.  In particular, I am concerned
> >=0D
> > How many is "some"? If it's not >100 or so it is probably =0D
> not  worht=0D
> > the effort...
>=0D
> With the current design "some" is <50, but we can change the=0D
> design if we find it necessary.
> =0D
> >=0D
> > Use the standard methods: use the CF card read-only  (many =0D
> CF  cards=0D
> > can  be  damaged  [beyond  repair]  when  you power off=0D
> while a write=0D
> > operation is in progress).
>=0D
> Is this an acknowledged fact by CF manufacturers or based on=0D
> experiece ?
>=0D
> Thank you very much for your input.
>=0D
> Regards,
> J=F3n Benediktsson
> Marel hf.

Hi J=F3n,

Read the CF card detailed specifications carefully (and if it ain't in=
 writing, it ain't real).

What I've seen is marketing bullet points saying the cards can survive a=
 power loss event with no loss of data, but when I read the detailed CF=
 specification, the disclaimer was that power had to be held up for X mSec=
 (I forgot what X was, 2mSec or 10mSec most likely) after the last write=
 operation.  The marketing bullet point was exactly that: marketing.  The=
 real requirement levied on the user (you) was that you had to have X mSec=
 power hold up after the last write operation (i.e. a X mSec power fail=
 warning with no write operations after the PF warning).  The hold-up=
 requirement gave the CF internals enough time to complete a flash write=
 cycle.

gvb

******************************************
The following messages are brought to you by the Lawyers' League of=
 IdioSpeak:

******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************
