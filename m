Return-Path: <anton@ozlabs.org>
Date: Mon, 3 Apr 2006 11:40:44 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: _machine removal breaks kexec?
Message-ID: <20060403014044.GA4704@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

It looks like the _machine removal broke kexec:

 # kexec -l vmlinux
 /proc/device-tree/chosen/linux,platform: No such file or directory

The kexec tools seem to want the linux,platform property:

        /* if LPAR, no need to read any more from /chosen */
        if (platform != PLATFORM_PSERIES) {
                closedir(cdir);
                continue;
        }

Anton
