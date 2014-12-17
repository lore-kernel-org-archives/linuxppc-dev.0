Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04A831A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 20:27:39 +1100 (AEDT)
Message-ID: <54914C85.30107@suse.de>
Date: Wed, 17 Dec 2014 10:27:33 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable
 in current_thread_info
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>	<5490D981.7040905@suse.de>
 <20141217144459.09701a76@kryten>
In-Reply-To: <20141217144459.09701a76@kryten>
Content-Type: text/plain; charset=windows-1252
Cc: ulrich.weigand@de.ibm.com, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17.12.14 04:44, Anton Blanchard wrote:
> Hi Alex,
> 
>> Git bisect managed to point me to this commit as the offender for
>> OOPSes on e5500 and e6500 (and maybe the G4 as well, not sure).
>>
>> Doing a git revert of this commit on top of linus/master makes things
>> work fine for me again.
> 
> Ouch, sorry for that, I'll work to reproduce. What gcc version are you
> using?

I'm running

  gcc (SUSE Linux) 4.7.2 20130108 [gcc-4_7-branch revision 195012]

which is basically the one from openSUSE 12.3 for ppc64.

I've also uploaded 2 builds, one with the patch applied (broken) and one
without (works):

  http://csgraf.de/agraf/current_thread_info/vmlinux.broken.xz
  http://csgraf.de/agraf/current_thread_info/vmlinux.works.xz

Interestingly enough I did not see this on IBM POWER systems, but maybe
that's because most of them compile their own kernels with local,
different compilers in my test runs and the only one that does base on
the same compiler doesn't run on nfsroot.

My iBook G4 target is affected by this as well and reverting this patch
also makes it work again. Maybe we're just running over some stack?


Alex
