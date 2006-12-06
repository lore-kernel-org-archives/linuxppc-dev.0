Return-Path: <anton@ozlabs.org>
Date: Thu, 7 Dec 2006 08:16:30 +1100
From: Anton Blanchard <anton@samba.org>
To: olh@suse.de, linuxppc-dev@ozlabs.org
Subject: 2.6.19 cannot find root partition
Message-ID: <20061206211630.GB27857@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

The patch to identify AIX disks and ignore them has caused at least one
machine to fail to find the root partition on 2.6.19. The patch is:

http://lkml.org/lkml/2006/7/31/117

The problem is some disk formatters do not blow away the first 4 bytes
of the disk. If the disk we are installing to used to have AIX on it,
then the first 4 bytes will still have IBMA in EBCDIC.

The install in question was debian etch. Im not sure what the best fix
is, perhaps the AIX detection code could check more than the first 4
bytes.

Anton
