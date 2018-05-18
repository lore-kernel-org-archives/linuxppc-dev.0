Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nTH32xXvzF29r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 23:17:19 +1000 (AEST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>, Ram Pai <linuxram@us.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>
From: Florian Weimer <fweimer@redhat.com>
Subject: pkeys on POWER: Default AMR, UAMOR values
Message-ID: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
Date: Fri, 18 May 2018 15:17:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm working on adding POWER pkeys support to glibc.  The coding work is 
done, but I'm faced with some test suite failures.

Unlike the default x86 configuration, on POWER, existing threads have 
full access to newly allocated keys.

Or, more precisely, in this scenario:

* Thread A launches thread B
* Thread B waits
* Thread A allocations a protection key with pkey_alloc
* Thread A applies the key to a page
* Thread A signals thread B
* Thread B starts to run and accesses the page

Then at the end, the access will be granted.

I hope it's not too late to change this to denied access.

Furthermore, I think the UAMOR value is wrong as well because it 
prevents thread B at the end to set the AMR register.  In particular, if 
I do this

* … (as before)
* Thread A signals thread B
* Thread B sets the access rights for the key to PKEY_DISABLE_ACCESS
* Thread B reads the current access rights for the key

then it still gets 0 (all access permitted) because the original UAMOR 
value inherited from thread A prior to the key allocation masks out the 
access right update for the newly allocated key.

Thanks,
Florian
