Message-ID: <392C4F17.61D04687@mac.com>
Date: Wed, 24 May 2000 17:52:23 -0400
From: Tom <tdilling@mac.com>
Reply-To: tdilling@mac.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linuxppc-users@lists.linuxppc.org
Subject: yaboot problems (still -- suggestions welcome!)
Content-Type: multipart/mixed;
 boundary="------------C453CEF53100CF4F2CE3BA2A"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------C453CEF53100CF4F2CE3BA2A
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit

I've been struggling with it for over a week now, but am still unable to

yaboot (though I think I've made some minimal progress).

I have a G4/500 with linux on a dedicated external scsi drive (Adaptec
2906 card).

Per OF, the card corresponds to:
/pci@f2000000/pci-bridge@d/pci9004,7850@2/@2  (It is device 2 on the
scsi chain, or at least that's what the back of the hard drive implies.)

pdisk says the bootstrap partition is #2:
Partition map (with 512 byte blocks) on '/dev/sda'
 #:                type name                   length   base    ( size )

 1:    Apple_UNIX_SVR2 /            7785303 @ 204     (  3.7G)
 2:    Apple_HFS "bootstrap"         65638 @ 7785507 ( 32.0M)
 3:    Apple_UNIX_SVR2 swap    1048592 @ 7851145 (512.0M)
 [rest deleted]

Set the relevant line in /boot/ofboot.b (which is cp'd from the
menu_ofboot.b):
" Booting Yaboot ..." cr " boot sd:2,yaboot" eval

My /etc/yaboot.conf is as follows:
--------------
default=Linux-Stable

## change to your bootstrap partition ie /dev/hda2
boot=/dev/sda2
device=sd:
timeout=20
install=/boot/yaboot
magicboot=/boot/ofboot.b

image=/boot/vmlinux
 label=Linux-Stable
 root=/dev/sda1
 read-only
 partition=2

append= "video=aty128fb:vmode:17;cmode:24"
-----------------

Now, in OF, when I try to set sd as a devalias, it tells me the nvramrc
isn't valid.  When I printenv, I don't see it showing up anywhere (but
maybe I don't know what to look for, exactly?).

When in OF and I try to boot directly by providing the OF path manually,

I get this error:
method <open> not found ; ihandle=ff9c4980 phandle=ff8a9708 method
<close> not found ihandle=ff9c4980 phandle=ff8a9708 can't OPEN:
/pci@f2000000/.... {etc}.
I don't know what this means or what to do with this information.
(Anyone have any idea?)

One last thing: I have managed in the past week to get ybin working (my
bootstrap was mounted in the mtab).

But I have no idea how to proceed from here.  I'm about to start my
medical internship, and will have no more time to fiddle with this
starting about two weeks from now.

Sorry to whine!  :-)
Any/all suggestions most welcome!  Thanks!

Tom

Thomas Dilling, MD
tdilling@mac.com




--------------C453CEF53100CF4F2CE3BA2A
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <>
Received: from smtpin02.mac.com ([10.13.10.69]) by
          mail03.mac.com () with ESMTP id FV33BX00.S7Y for
          <tdilling@mac.com>; Wed, 24 May 2000 14:50:21 -0700
Received: from mustang.oldcity.dca.net ([216.158.38.3]) by
          smtpin02.mac.com () with ESMTP id FV33BW00.MDY for
          <tdilling@mac.com>; Wed, 24 May 2000 14:50:20 -0700
Received: from localhost (localhost)
	by mustang.oldcity.dca.net (8.9.3/8.9.3/DCANET) with internal id RAA15356;
	Wed, 24 May 2000 17:50:25 -0400
Date: Wed, 24 May 2000 17:50:25 -0400
From: Mail Delivery Subsystem <postmaster@postoffice.dca.net>
Message-Id: <200005242150.RAA15356@mustang.oldcity.dca.net>
To: <tdilling@mac.com>
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="RAA15356.959205025/mustang.oldcity.dca.net"
Subject: Returned mail: Host unknown (Name server: lists.linuxppc.com: host not found)
Auto-Submitted: auto-generated (failure)
X-Mozilla-Status2: 00000000

This is a MIME-encapsulated message

--RAA15356.959205025/mustang.oldcity.dca.net

The original message was received at Wed, 24 May 2000 17:50:22 -0400
from adsl-216-158-26-6.cust.oldcity.dca.net [216.158.26.6]

             * This message generated automatically *

Your e-mail message has been deferred or was unable to be delivered.
Below is the error message from DCANet's mail system.  If you do not
understand what this output means, please forward this entire message
along with a request for assistance to help@dca.net.   You may also call
DCANet's helpdesk toll free at +1 888 4DCANET (+1 888 432 2638) during
regular business hours.

  * Do not reply to this message - for assistance, mail help@dca.net *




   ----- The following addresses had permanent fatal errors -----
<linuxppc-dev@lists.linux.com>
<linuxppc-user@lists.linuxppc.com>

   ----- Transcript of session follows -----
550 <linuxppc-dev@lists.linux.com>... Host unknown (Name server: lists.linux.com: host not found)
550 <linuxppc-user@lists.linuxppc.com>... Host unknown (Name server: lists.linuxppc.com: host not found)

--RAA15356.959205025/mustang.oldcity.dca.net
Content-Type: message/delivery-status

Reporting-MTA: dns; mustang.oldcity.dca.net
Received-From-MTA: DNS; adsl-216-158-26-6.cust.oldcity.dca.net
Arrival-Date: Wed, 24 May 2000 17:50:22 -0400

Final-Recipient: RFC822; linuxppc-dev@lists.linux.com
Action: failed
Status: 5.1.2
Remote-MTA: DNS; lists.linux.com
Last-Attempt-Date: Wed, 24 May 2000 17:50:23 -0400

Final-Recipient: RFC822; linuxppc-user@lists.linuxppc.com
Action: failed
Status: 5.1.2
Remote-MTA: DNS; lists.linuxppc.com
Last-Attempt-Date: Wed, 24 May 2000 17:50:23 -0400

--RAA15356.959205025/mustang.oldcity.dca.net
Content-Type: message/rfc822

Return-Path: <tdilling@mac.com>
Received: from mac.com (adsl-216-158-26-6.cust.oldcity.dca.net [216.158.26.6])
	by mustang.oldcity.dca.net (8.9.3/8.9.3/DCANET) with ESMTP id RAA15353;
	Wed, 24 May 2000 17:50:22 -0400
Message-ID: <392C4E98.4542D218@mac.com>
Date: Wed, 24 May 2000 17:50:17 -0400
From: Tom <tdilling@mac.com>
Reply-To: tdilling@mac.com
X-Mailer: Mozilla 4.73 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linuxppc-dev@lists.linux.com, linuxppc-user@lists.linuxppc.com,
        ericpeden@homemail.com
Subject: yaboot problmes (still-- suggestions welcome!)
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit

I've been struggling with it for over a week now, but am still unable to
yaboot (though I think I've made some minimal progress).

I have a G4/500 with linux on a dedicated external scsi drive (Adaptec
2906 card).

Per OF, the card corresponds to:
/pci@f2000000/pci-bridge@d/pci9004,7850@2/@2  (It is device 2 on the
scsi chain, or at least that's what the back of the hard drive implies.)

pdisk says the bootstrap partition is #2:
Partition map (with 512 byte blocks) on '/dev/sda'
 #:                type name                   length   base    ( size )

 1:    Apple_UNIX_SVR2 /            7785303 @ 204     (  3.7G)
 2:    Apple_HFS "bootstrap"         65638 @ 7785507 ( 32.0M)
 3:    Apple_UNIX_SVR2 swap    1048592 @ 7851145 (512.0M)
 [rest deleted]

Set the relevant line in /boot/ofboot.b (which is cp'd from the
menu_ofboot.b):
" Booting Yaboot ..." cr " boot sd:2,yaboot" eval

My /etc/yaboot.conf is as follows:
--------------
default=Linux-Stable

## change to your bootstrap partition ie /dev/hda2
boot=/dev/sda2
device=sd:
timeout=20
install=/boot/yaboot
magicboot=/boot/ofboot.b

image=/boot/vmlinux
 label=Linux-Stable
 root=/dev/sda1
 read-only
 partition=2

append= "video=aty128fb:vmode:17;cmode:24"
-----------------

Now, in OF, when I try to set sd as a devalias, it tells me the nvramrc
isn't valid.  When I printenv, I don't see it showing up anywhere (but
maybe I don't know what to look for, exactly?).

When in OF and I try to boot directly by providing the OF path manually,
I get this error:
method <open> not found ; ihandle=ff9c4980 phandle=ff8a9708 method
<close> not found ihandle=ff9c4980 phandle=ff8a9708 can't OPEN:
/pci@f2000000/.... {etc}.
I don't know what this means or what to do with this information.
(Anyone have any idea?)

One last thing: I have managed in the past week to get ybin working (my
bootstrap was mounted in the mtab).

But I have no idea how to proceed from here.  I'm about to start my
medical internship, and will have no more time to fiddle with this
starting about two weeks from now.

Sorry to whine!  :-)
Any/all suggestions most welcome!  Thanks!
Tom

Thomas Dilling, MD
tdilling@mac.com



--RAA15356.959205025/mustang.oldcity.dca.net--


--------------C453CEF53100CF4F2CE3BA2A--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
