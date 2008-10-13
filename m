Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18675.49240.822253.691524@cargo.ozlabs.ibm.com>
Date: Tue, 14 Oct 2008 08:40:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Subject: RE: [PATCH] remove bogus ppc_select syscall
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D5F6F58@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D5F6F58@insardxms01.ap.sony.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sadashiiv, Halesh writes:

> I have tested the testcase that I have provided at the time of reporting
> this issue. But it didn't work as expected with the above patch you
> provided.
> (Failed to return EINVAL on negative value of n to select())

How is your testcase invoking select?  Is it doing its own hand-coded
system call using __NR_select?  If so the testcase is broken - it
should be using __NR__newselect.

If the test is using the ordinary glibc select(), then please send the
source code of the test program.

Paul.
