Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A9181A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 02:15:53 +1000 (AEST)
Message-ID: <55C4D9B2.3000708@mleia.com>
Date: Fri, 07 Aug 2015 19:15:46 +0300
From: Vladimir Zapolskiy <vz@mleia.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana>
In-Reply-To: <20150807161055.GD25357@katana>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On 07.08.2015 19:10, Wolfram Sang wrote:
> Vladimir,
> 
> On Mon, Jul 27, 2015 at 12:18:22AM +0300, Vladimir Zapolskiy wrote:
>> This change removes a number of redundant checks on bin attribute
>> client's side, the same checks are done by sysfs_kf_bin_read() or
>> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
>>
>> Note, drivers/misc/pch_phub.c and drivers/misc/c2port/core.c may be
>> updated in a similar way, however this task is not done due to more
>> complicated read()/write() callbacks.
> 
> Can you resend the patches which touch i2c drivers with me on cc? I'd
> like to take care of them.

if we're talking about this particular series, you should have them in
your mailbox, since you have them applied in wsa/i2c/for-next:

commit d12c0aaf3780c5b26b4ea9e795252381f586c063
Author: Vladimir Zapolskiy <vz@mleia.com>
Date:   Mon Jul 27 00:18:51 2015 +0300

    misc: eeprom: at24: clean up at24_bin_write()

    The change removes redundant sysfs binary file boundary check, since
    this task is already done on caller side in fs/sysfs/file.c

    Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

commit 1f023297f7f77d434ecc221018d2e181eac0ae36
Author: Vladimir Zapolskiy <vz@mleia.com>
Date:   Mon Jul 27 00:16:31 2015 +0300

    i2c: slave eeprom: clean up sysfs bin attribute read()/write()

    The change removes redundant sysfs binary file boundary checks,
    since this task is already done on caller side in fs/sysfs/file.c

    Note, on file size overflow read() now returns 0, and this is a
    correct and expected EOF notification according to POSIX.

    Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>


Do you want me to send them to you again anyway?

--
With best wishes,
Vladimir
