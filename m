Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 059D5DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 14:24:34 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1312459anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 21:24:33 -0700 (PDT)
Message-ID: <fa686aa40807272124td830126r2fa7a08a1509245d@mail.gmail.com>
Date: Sun, 27 Jul 2008 22:24:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: Re: Please pull mpc52xx-next
In-Reply-To: <fa686aa40807271448tb387f06xe380f7941fb7d331@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807252100q299f87d7xc2101869a45704bb@mail.gmail.com>
	<fa686aa40807271448tb387f06xe380f7941fb7d331@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 27, 2008 at 3:48 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Jul 25, 2008 at 10:00 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> Hey Ben, here are a few more patches for .27.  I would have had this
>> stuff in earlier, but they depended on another patch that I didn't
>> feel like I should push that was in Andrew's queue.
>>
>> Grant Likely (4):
>>      of: adapt of_find_i2c_driver() to be usable by SPI also
>>      spi: split up spi_new_device() to allow two stage registration.
>>      spi: Add OF binding support for SPI busses
>>      powerpc/mpc5200: Add mpc5200-spi (non-PSC) device driver
>
> Oops, I shouldn't have merged this last one.  Please don't pull this
> tree yet.  I'll fix it up this evening.

Okay, I've got it sorted out now.  Here is the new pull request:

The following changes since commit 024e8ac04453b3525448c31ef39848cf675ba6db:
  Roland McGrath (1):
        x86_64: fix ia32 AMD syscall audit fast-path

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant Likely (3):
      of: adapt of_find_i2c_driver() to be usable by SPI also
      spi: split up spi_new_device() to allow two stage registration.
      spi: Add OF binding support for SPI busses

 drivers/of/Kconfig      |    6 ++
 drivers/of/Makefile     |    1 +
 drivers/of/base.c       |   88 ++++++++++++++++++++++++++++++
 drivers/of/of_i2c.c     |   64 +---------------------
 drivers/of/of_spi.c     |   93 +++++++++++++++++++++++++++++++
 drivers/spi/spi.c       |  139 ++++++++++++++++++++++++++++++++---------------
 include/linux/of.h      |    1 +
 include/linux/of_spi.h  |   18 ++++++
 include/linux/spi/spi.h |   12 ++++
 9 files changed, 317 insertions(+), 105 deletions(-)
 create mode 100644 drivers/of/of_spi.c
 create mode 100644 include/linux/of_spi.h

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
