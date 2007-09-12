Return-Path: <MBenedict@twacs.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94FEEDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 00:57:03 +1000 (EST)
Received: from outbound1-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-dub-R.bigfish.com (Postfix) with ESMTP id 1E04B1BC82F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 14:57:09 +0000 (UTC)
Received: from mail173-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound1-dub.bigfish.com (Postfix) with ESMTP id 0DBB01B30066
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 14:57:09 +0000 (UTC)
Received: from mail173-dub (localhost.localdomain [127.0.0.1])
	by mail173-dub-R.bigfish.com (Postfix) with ESMTP id 7CDED10B0211
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 14:55:29 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail173-dub.bigfish.com (Postfix) with ESMTP id 1569617A807A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 14:55:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: futex priority based wakeup
Date: Wed, 12 Sep 2007 09:56:51 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BEB@twx-exch01.twacs.local>
In-Reply-To: <1656e050709111714g1a84656bvd7823f5fc43345dd@mail.gmail.com>
References: <BAF8B1E0BB28024A90895E746A3B610D1C2BE7@twx-exch01.twacs.local>
	<000001c7f4c7$7a7ab5c0$3a0d10ac@Radstone.Local>
	<1656e050709111714g1a84656bvd7823f5fc43345dd@mail.gmail.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
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

Nguyen Nguyen wrote:
> I have seen something similar before.  Our fix was to use
> pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED)
> so child threads wouldn't inherit attribute from parent.

> On 9/11/07, Ilya Lipovsky <lipovsky@cs.bu.edu> wrote:
>=20
> 	Hmm. Just for kicks - inside the important thread could you add:
<snip>
> 	printf("important's policy is %d and priority is %d\n",
curpolicy,
<snip>
> 	Do similar for the unimportant thread, and see if you
> get anything weird -
> 	e.g. priorities come out to be the same for threads.


Thank you both!  You were each correct, and your input has been greatly
appreciated.

Adding the printf() resulted in:
unimportant's policy is 0 and priority is 0
unimportant waiting for futex
important's policy is 0 and priority is 0
important waiting for futex
main's policy is 0 and priority is 0
futex FUTEX_WAKE
unimportant's policy is 0 and priority is 0
unimportant got futex!
important's policy is 0 and priority is 0
important got futex!

Adding the PTHREAD_EXPLICIT_SCHED resulted in:
unimportant's policy is 1 and priority is 1
unimportant waiting for futex
important's policy is 1 and priority is 99
important waiting for futex
main's policy is 0 and priority is 0
futex FUTEX_WAKE
important's policy is 1 and priority is 99
important got futex!
unimportant's policy is 1 and priority is 1
unimportant got futex!

Verifying with pthread_muxtex / glibc 2.3.6:
unimportant's policy is 1 and priority is 1
unimportant waiting for mutex
important's policy is 1 and priority is 99
important waiting for mutex
main's policy is 0 and priority is 0
main unlocking mutex
important's policy is 1 and priority is 99
important got mutex!
unimportant's policy is 1 and priority is 1
unimportant got mutex!

And, to come full circle, regression on 2.6.21 resulted in:
unimportant's policy is 1 and priority is 1
unimportant waiting for futex
important's policy is 1 and priority is 99
important waiting for futex
main's policy is 0 and priority is 0
futex FUTEX_WAKE
unimportant's policy is 1 and priority is 1
unimportant got futex!
important's policy is 1 and priority is 99
important got futex!

Now it is time to audit my other code and make sure to add
PTHREAD_EXPLICIT_SCHED where appropriate.  Thank you.
	-Michael
