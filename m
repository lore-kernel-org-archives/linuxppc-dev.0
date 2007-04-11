Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id 66483DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 11:30:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS 
Date: Tue, 10 Apr 2007 18:30:27 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F28@monk.echelon.echcorp.com>
In-reply-to: <20070410171724.B0CDF353B4B@atlas.denx.de>
References: Your message of "Mon, 09 Apr 2007 18:33:30 PDT."
	<DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
	<20070410171724.B0CDF353B4B@atlas.denx.de>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the guidance, Ben, David, and Wolfgang.

The root ELDK 4.1 build problem seems to be that Fedora has further
updated their core 4 SRPMs without saving the old SRPMs on their ftp
site. Plus I need to use an FC5 build PC instead of RHEL 4.

For example, if I turn on echo in ELDK_BUILD script, here is an example
of one of the failures that led me to look elsewhere for SRPMS:
+ rm -f rpm-4.4.1-22.src.rpm
+ ncftpget -v
ftp://download.fedora.redhat.com/pub/fedora/linux/core/4/SRPMS/rpm-4.4.1
-22.src.rpm
ncftpget: server said: Failed to open file.
+ ncftpget -v
ftp://download.fedora.redhat.com/pub/fedora/linux/core/updates/4/SRPMS/r
pm-4.4.1-22.src.rpm
ncftpget: server said: Failed to open file.

But if I MANUALLY try to get the current build 23, it works:
cd /home/gkenaley/ELDK/V4.1/SRPMS
ncftpget -v
ftp://download.fedora.redhat.com/pub/fedora/linux/core/updates/4/SRPMS/r
pm-4.4.1-23.src.rpm
rpm-4.4.1-23.src.rpm:                                   10.97 MB  106.61
kB/s

So I Googled around and finally found all of the missing FC4 SRPMS
except for "util-linux-2.12p-9.12.src.rpm". The best sites that I could
find to obtain the SRPMS were:
http://download.stmc.edu.hk/fedora/linux/core/updates/4/SRPMS/
http://www.distro-cd.org/PatchCD/Fedora/Core4/SRPMS/

I had to change SRPMS.lst to use the closest available SRPM,
"util-linux-2.12p-9.13.src.rpm"

I also set up and updated an FC5 build machine, and it looks like the
ELDK 4.1 build is going through okay.

Next I will try updating to u-boot 1.1.6 on the MPC8349E MDS.

Thanks, Gary


> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]
> Sent: Tuesday, April 10, 2007 10:17 AM
> To: Gary Kenaley
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS
>=20
> In message
> <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
you
> wrote:
> >
> ...
> [Comments on questions already answered by Ben Warren omitted.]
> >
> > I also tried a "full source rebuild from scratch" for the ELDK 4.1,
but
> > I found that these SRPMS were originally misnamed (could not be
found in
> > CVS, rpmfind, or the ELDK source CD-ROM) in
> > /home/gkenaley/ELDK/V4.1/build/SRPMS.lst:
>=20
> You misunderstand. Please read the documentation. The SRPMs listed in
> SRPMS.lst are the original Fedora Core SRPMs which are used as  input
> to  the  ELDK  build  process.  The SRPMs on the Source CDROM are the
> source RPMs created by the ELDK build, i. e. it's output.
>=20
> > After correcting (?) SRPMS.lst to contain the names shown above, the
>=20
> You did not correect it, you corrupted it instead.
>=20
> > 2. Any idea why I have problems doing the "ELDK 4.1 full source
rebuild
> > from scratch"?
>=20
> Because you did not follow the documentation.
>=20
> Note that you should use either RedHat Linux 7.3  or  Fedora  Core  5
> (both  with  all  updates  installed) as build environment - at least
> these are the only officially supported build environments.
>=20
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
> --
> DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
> Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Power is danger.
> 	-- The Centurion, "Balance of Terror", stardate 1709.2
