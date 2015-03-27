Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 149E71A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 23:01:37 +1100 (AEDT)
In-Reply-To: <1421144560-15901-7-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V2, 06/12] selftests,
 powerpc: Add test for system wide DSCR default
Message-Id: <20150327120136.EF3431400DE@ozlabs.org>
Date: Fri, 27 Mar 2015 23:01:36 +1100 (AEDT)
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-13-01 at 10:22:34 UTC, Anshuman Khandual wrote:
> This patch adds a test case for the system wide DSCR default
> value, which when changed through it's sysfs interface must
> be visible to all threads reading DSCR either through the
> privilege state SPR or the problem state SPR. The DSCR value
> change should be immediate as well.
 
...

> +
> +/* Default DSCR access */
> +unsigned long get_default_dscr(void)
> +{
> +	int fd = -1;
> +	char buf[16];
> +	unsigned long val;
> +
> +	if (fd == -1) {
> +		fd = open(DSCR_DEFAULT, O_RDONLY);
> +		if (fd == -1) {
> +			perror("open() failed\n");
> +			exit(1);
> +		}
> +	}
> +	memset(buf, 0, sizeof(buf));
> +	lseek(fd, 0, SEEK_SET);
> +	read(fd, buf, sizeof(buf));


This and the other tests are failing to build:

    In file included from dscr_default_test.c:16:0:
    dscr.h: In function ‘get_default_dscr’:
    dscr.h:93:6: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
      read(fd, buf, sizeof(buf));
          ^
    dscr.h: In function ‘set_default_dscr’:
    dscr.h:112:7: error: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Werror=unused-result]
      write(fd, buf, strlen(buf));
           ^
    cc1: all warnings being treated as errors

cheers
