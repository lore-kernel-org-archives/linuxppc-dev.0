Return-Path: <hubert.loewenguth@thales-bm.com>
Received: from thsmsgxrt12p.thalesgroup.com (thsmsgxrt12p.thalesgroup.com
	[192.54.144.135]) by ozlabs.org (Postfix) with ESMTP id 4F4B967B74
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 01:30:54 +1000 (EST)
Received: from thsmsgirt22p.corp.thales (unknown [10.33.231.6])
	by thsmsgxrt12p.thalesgroup.com (Postfix) with ESMTP id 3EB224416E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 17:25:42 +0200 (CEST)
Received: from [10.33.231.31] (10.33.231.31) by thsmsgirt22p.corp.thales
	(7.2.055.4) id 44447C9500AEC0FC for linuxppc-embedded@ozlabs.org;
	Thu, 15 Jun 2006 17:25:41 +0200
Received: from cnfplex.tbm.fr.thales (unknown [10.33.13.187])
	by thsmsgirt12p.corp.thales (Postfix) with ESMTP id 2C14C3C020
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 17:25:42 +0200 (CEST)
Received: from [178.1.60.47] (178.1.60.47) by cnfplex.tbm.fr.thales (NPlex
	6.5.026) id 448E4D3000003573 for linuxppc-embedded@ozlabs.org;
	Thu, 15 Jun 2006 17:25:42 +0200
Message-ID: <44917BF1.5070700@thales-bm.com>
Date: Thu, 15 Jun 2006 17:25:37 +0200
From: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: cramfs and crontab timestamp
Content-Type: multipart/mixed; boundary="------------080905070803020401040300"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080905070803020401040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi to the community

I'm not sure here is the good place for my question because it's not 
related to the ppc architecture, but i try.
Here is my problem I don't understand:
I have an embended linux 2.4.20 on a 8260 ppc with a cramfs root 
file-system I use since 1 year.
Everything works fine.
During the init process, the content of the /etc directory is copy in a 
tmpfs file system and then then a tmpfs file-system is mounted on /etc 
and fill with the old content.
(thanks to that, I can replace after some files in the /etc by other 
specific files store in a little jffs part of the flash with the 
customer specific configurations /etc configuration files).

Recently, I've decided to add cron to this platform and something very 
strange appear.
My /etc/crontab file is very simple:

-----------------------------------------------
SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=""
HOME=/

#test of cron
* * * * * root echo date >>/tmp/essai
-----------------------------------------------

everything works fine when I boot on a nfs file-system.
But nothing is done (/tmp/essai not created) if I boot on the cramfs 
file-system.
And what is the only difference beetwen the two startup:........ the 
timestamp of the /etc/crontab (1/1/1970 for crontab coming from the cramfs)

So I try something after having boot on cramfs:
echo "#toto">>/etc/crontab

And ones  I have done this, the cron process start to work correctly, 
creating and editing the /tmp/essai.
I know that cron verify if the /etc/crontab has changed every mn, so I 
think this is the reason it works after, but why does it not see the 
first crontab file ?
It's juste like the 1/1/1970 timestamp of /etc/crontab make him 
invisible by cron.

Does anyone having an idea or having already encounter this kind of 
problem ?
I have find nothing on the web about this or a similar problem.

Thanks for any help


--------------080905070803020401040300
Content-Type: text/x-vcard; charset=utf-8;
 name="hubert.loewenguth.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hubert.loewenguth.vcf"

begin:vcard
fn:Hubert Loewenguth
n:Loewenguth;Hubert
org:Thales Broadcast & Multimedia
adr:;;1 rue de l'hautil;Conflans Ste Honorine;;78700;France
email;internet:hubert.loewenguth@thales-bm.com
title:Software Engineer
tel;work:01-34-90-37-56
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------080905070803020401040300--
