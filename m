Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZnT21rxWzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 23:48:37 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org
From: Florian Weimer <fweimer@redhat.com>
Subject: Kernel 4.15 lost set_robust_list support on POWER 9
Cc: Jiri Slaby <jslaby@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
Date: Mon, 5 Feb 2018 13:48:33 +0100
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

I get this:

7041  set_robust_list(0x7fff93dc3980, 24) = -1 ENOSYS (Function not 
implemented)

The system call works on 4.14.  Looks like the probing for 
futex_cmpxchg_enabled goes wrong.

Sorry, I have no idea where to start digging.  I don't see anything 
obvious in dmesg.

I'm trying to revert

commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Aug 24 09:31:05 2017 +0200

     futex: Remove duplicated code and fix undefined behaviour

to see if it makes a difference.

Thanks,
Florian
