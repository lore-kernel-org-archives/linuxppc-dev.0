Return-Path: <geoff@infradead.org>
Subject: Re: ps3 linux: os_area_queue_work_handler: Could not update FLASH ROM
To: Sombat Tragolgosol <sombat3960@gmail.com>, Linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jk@ozlabs.org>
References: <CAC1vu63d9t3vdfz_+62hDc94tfG=rRN757RezXh8wSNwnYdmZg@mail.gmail.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <f3e6f786-e35a-c105-5749-c74e4463c721@infradead.org>
Date: Mon, 26 Jun 2017 10:24:54 -0700
MIME-Version: 1.0
In-Reply-To: <CAC1vu63d9t3vdfz_+62hDc94tfG=rRN757RezXh8wSNwnYdmZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sombat,

On 06/26/2017 02:26 AM, Sombat Tragolgosol wrote:
> 1) Is it normal for os_area_queue_work_handler: Could not update FLASH ROM?

You should try to find the exact cause of the error.  It could be due to a
corrupted os-area.

> 2) My Date time is not correct.  Is the problem is not able to update os-area data?
> 
> Here below is my rtc time problem.
> 
> RTC time is not proper value (lower than it should be).
> (For GameOS , Date-Time is OK.)
> 
> Here is what I've tried
>    1) lv1_get_rtc gets 205943663 (11 Jul 1976)
>    2) saved_params.rtc_diff always is 946684800
>         (205943663+946684800) = 11 Jul 2006
>    So every time, my Linux is booted,  my year says 2006 and causes problem on clock skew.
>    3) if I add 345746286 to rtc in read_rtc function in
>       arch/powerpc/platforms/ps3/time.c and
>       drivers/rtc/rtc-ps3.c
>       (205943663+946684800+345746286) = 25 Jun 2017
>    My boot time and date is acceptable for my temporary use.
> 
>    Do you have any proper solution? I don't want to modify source for my one rtc time problem?

Your problem is that the os-area database value is wrong and is not being set.

The RTC hardware of the PS3 cannot be reset, so each OS (game-os and Linux) needs
to maintain a difference between the hardware RTC value and the value it
uses for time.

A read-only copy of the game-os diff is put at os_area_params.rtc_diff.  You can read
that with 'ps3-flash-util --game-time'. For Linux we keep that difference in the
os-area database (db_area_offset + OS_AREA_DB_OWNER_LINUX + OS_AREA_DB_KEY_RTC_DIFF).

See:

  https://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-docs/PlatformSpecificUtilities.html

First you should try to set the os-area value with 'ps3-rtc-init --force'.  Look at
the ps3-rtc-init source to see how to set the rtc diff value yourself:

  https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-utils.git/tree/ps3-rtc-init.in#n69

Maybe you need to re-format the os-area database 'ps3-flash-util ----db-format'.  Make
a backup first.  See '** backup flash data **' here:

  https://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-howto/ps3-boot-recovery-howto.txt

-Geoff
