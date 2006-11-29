Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17773.18027.177795.192632@cargo.ozlabs.ibm.com>
Date: Wed, 29 Nov 2006 19:35:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ryusuke Konishi <ryusuke@osrg.net>
Subject: Re: [PATCH 2.6.19-rc6] powerpc: fix of_device __must_check warning
In-Reply-To: <20061129.140751.48374104.ryusuke@osrg.net>
References: <20061129.140751.48374104.ryusuke@osrg.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ryusuke Konishi writes:

> This fixes the following compile warning:
> 
> arch/powerpc/kernel/of_device.c: In function 'of_device_register':
> arch/powerpc/kernel/of_device.c:199: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Your patch also makes a policy change, though, in that without your
patch, a failure in creating the "devspec" file in sysfs doesn't
prevent of_device_register from performing its main function.  With
your patch, of_device_register will fail if we can't create the
"devspec" file.

On the whole, I am inclined to think that it is useful for
of_device_register to succeed even if the devspec file can't be
created, since nothing in the kernel relies on the devspec file being
present.

Paul.
