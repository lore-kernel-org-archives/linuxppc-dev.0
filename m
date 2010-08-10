Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 91A8FB70A7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:40:43 +1000 (EST)
Received: by iwn41 with SMTP id 41so4335039iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 23:40:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Aug 2010 00:40:21 -0600
Message-ID: <AANLkTim=Qc-zA=9E0SfOB+8V48Y957MXkefD324xoq0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
To: Mingkai Hu <Mingkai.hu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 2, 2010 at 1:51 AM, Mingkai Hu <Mingkai.hu@freescale.com> wrote=
:
> Refactor the common code in file spi_mpc8xxx.c to spi_fsl_lib.c
> used by SPI/eSPI controller driver as a library, move the SPI
> controller driver to a new file spi_fsl_spi.c, and leave the
> QE/CPM SPI controller code in this file.
>
> Because the register map of the SPI controller and eSPI controller
> is so different, also leave the code operated the register to the
> driver code, not the common code.
>
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> v2:
> =A0- Rename spi_mpc8xxx.c to spi_fsl_lib.c, also the config name
> =A0- Rename fsl_spi.c to spi_fsl_spi.c, also the config name
> =A0- Move register map definiton from spi_fsl_lib.c to spi_fsl_spi.c
> =A0- Break some funcions line in the arguments instead of the declaration
> =A0- Init bits_per_word to 0 to eliminate the else clause
> =A0- Add brace for the else clause to match if clause
> =A0- Drop the last entry's comma in the match table
> =A0- move module_init() immediately after the init fsl_spi_init() functio=
n
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 20 +-
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/spi/spi_fsl_lib.c | =A0237 ++++++++
> =A0drivers/spi/spi_fsl_lib.h | =A0119 ++++
> =A0drivers/spi/spi_fsl_spi.c | 1173 +++++++++++++++++++++++++++++++++++++
> =A0drivers/spi/spi_mpc8xxx.c | 1421 -------------------------------------=
--------

This patch seems pretty good now.  However, the rename from
spi_mpc8xxx.c to spi_fsl_lib.c should be done in a separate patch.  It
is too difficult to track what has changed, when the file gets moved
at the same time.  Move the file in one patch verbatim (with the
required Makefile change), and then move out the fsl_spi specific bits
in a second patch.

g.
