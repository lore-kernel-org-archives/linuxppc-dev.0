Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6v8L3bGSzDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 11:41:04 +1100 (AEDT)
Date: Wed, 04 Oct 2017 17:40:55 -0700 (PDT)
Message-Id: <20171004.174055.1185097411151057568.davem@davemloft.net>
To: keescook@chromium.org
Cc: tglx@linutronix.de, akpm@linux-foundation.org, arnd@arndb.de,
 benh@kernel.crashing.org, cmetcalf@mellanox.com, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, linux@roeck-us.net, harish.patil@cavium.com,
 heiko.carstens@de.ibm.com, jejb@linux.vnet.ibm.com,
 john.stultz@linaro.org, jwi@linux.vnet.ibm.com, kvalo@qca.qualcomm.com,
 jiangshanlai@gmail.com, len.brown@intel.com, manish.chopra@cavium.com,
 mark.gross@intel.com, martin.petersen@oracle.com, schwidefsky@de.ibm.com,
 mpe@ellerman.id.au, mdr@sgi.com, netdev@vger.kernel.org, oleg@redhat.com,
 paulus@samba.org, pavel@ucw.cz, pmladek@suse.com, rjw@rjwysocki.net,
 ralf@linux-mips.org, sre@kernel.org, stefanr@s5r6.in-berlin.de,
 sboyd@codeaurora.org, sudipm.mukherjee@gmail.com, tj@kernel.org,
 ubraun@linux.vnet.ibm.com, viresh.kumar@linaro.org, wim@iguana.be,
 linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from
 DEFINE_TIMER
From: David Miller <davem@davemloft.net>
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-11-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kees Cook <keescook@chromium.org>
Date: Wed,  4 Oct 2017 16:27:04 -0700

> Drop the arguments from the macro and adjust all callers with the
> following script:
> 
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts

For networking:

Acked-by: David S. Miller <davem@davemloft.net>
