Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 85002B712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 00:43:13 +1000 (EST)
Received: by gyh4 with SMTP id 4so3313522gyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Sep 2010 07:43:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Sep 2010 08:42:49 -0600
Message-ID: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
Subject: ERR_PTR pattern in phylib
To: Andy Fleming <afleming@freescale.com>, netdev <netdev@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andy,

I've been looking at the phylib code, and specifically at the use of
the ERR_PTR() pattern.  I'm personally not a big fan of ERR_PTR()
because the compiler cannot type check the result and it runs
completely counter to the pattern "if (!ptr)" than is common for
testing a pointer return value.

(That being said, I do understand the need for it in certain parts of
the kernel (like the filesystem code) where it is important to be both
efficient because it is a hot path and still able to accurately return
an error code that is used by userspace.)

It seems to me that phylib is one of the cases where the users (the
network drivers) don't actually care about the specific error code
when calling phylib functions.  The drivers only seem to care whether
or not the function failed, and if it did then bail out.  I've also
noticed that using the "if (!ptr)" test on phylib return values is a
common error for driver writers.

In the interest of making driver code easier to write and review,
would you be opposed to a set of patches to remove the ERR_PTR()
pattern from phylib and its users?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
