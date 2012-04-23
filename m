Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31631B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 17:08:01 +1000 (EST)
Received: by obbuo19 with SMTP id uo19so7504437obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 00:07:58 -0700 (PDT)
Date: Mon, 23 Apr 2012 00:06:41 -0700
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v3 0/9] Fixes for common mistakes w/ for_each_process and
 task->mm
Message-ID: <20120423070641.GA27702@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linaro-kernel@lists.linaro.org, Mike Frysinger <vapier@gentoo.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, patches@linaro.org,
 linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This is another resend of several task->mm fixes, the bugs I found
during LMK code audit. Architectures were traverse the tasklist
in an unsafe manner, plus there are a few cases of unsafe access to
task->mm in general.

There were no objections on the previous resend, and the final words
were somewhere along "the patches are fine" line.

In v3:
- Dropped a controversal 'Make find_lock_task_mm() sparse-aware' patch;
- Reword arm and sh commit messages, per Oleg Nesterov's suggestions;
- Added an optimization trick in clear_tasks_mm_cpumask(): take only
  the rcu read lock, no need for the whole tasklist_lock.
  Suggested by Peter Zijlstra.

In v2: 
- introduced a small helper in cpu.c: most arches duplicate the
  same [buggy] code snippet, so it's better to fix it and move the
  logic into a common function.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
