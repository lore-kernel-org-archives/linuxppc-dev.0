Return-Path: <nd@bplan-gmbh.de>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id 222FD679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 15:31:11 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0701.wanadoo.fr (SMTP Server) with ESMTP id 772717000099
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 07:31:08 +0200 (CEST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: 02 Jun 2005 07:29:25 +0100
In-Reply-To: <1117664786.19020.81.camel@gaston>
Message-Id: <20050602053107.111887000086@mwinf0701.wanadoo.fr>
Subject: Re: Tiny patch for arch/ppc/kernel/cputable.c to properly support the IBM
 PowerPC 750CXe rev 3.1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Benjamin,

On 01/06/2005, you wrote:
> On Wed, 2005-06-01 at 19:14 +0100, Nicolas DET wrote:
>> Hello,
>> 
>> You can find enclosed a small patch to properly support the 750 CXe rev
>> 3.1. Indeed, the current kernel (2.6.11.11) only supports rev 2.1 and
>> ignores 3.1
>> 
>> It's a tiny patch: it only add an entry in the table with the correct
>> PVR and name. Others values has been copied from 750CXe rev 2.1.
>> 
>> I succesfully patched & compiled a vanila 2.6.11.11 from kernel.org.

> Is it needed ? I have it in my local tree and never actuall remembered
> to actually send it :) In general, that kind of entries are really only
> needed when there is a feature change...

.cpu_features is exactly the same compare to 745/755 (750CXe 3.1, PVR 0008
3311, was probed as 745/755). However, there is a small difference: It now
calls __setup_cpu_750cx instead of __setup_cpu_750.
This end up calling setup_750cx which looks like to disable NAP.

Well, I did not notice anything before and after the patch. It's more
'comsetic': cpuinfo shows the correct cpu name. :-)

Regards
-- 
Nicolas DET
MorphOS & Linux developer
