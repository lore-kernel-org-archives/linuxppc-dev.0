Return-Path: <pochini@shiny.it>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by ozlabs.org (Postfix) with ESMTP id 9D4EEDDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 09:18:22 +1100 (EST)
Date: Mon, 8 Dec 2008 23:07:45 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@ozlabs.org
Subject: odd dxfer_len == crash
Message-Id: <20081208230745.cb0bec11.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ioctl(SG_IO) with odd dxfer_len hangs the machine. I have a dual G4 MDD and
and ide dvd-rw and I can't locate che bug. I'm posting here because the
program below doesn't crash on a PC. Any clue? TIA.

Linux Jay 2.6.27 #2 SMP Wed Oct 15 00:33:06 CEST 2008 ppc 7455, altivec supported PowerMac3,6 GNU/Linux



#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <scsi/sg.h>

#define TOCLEN 0xbf	// 0xbf 191


int main() {
  int fd, ret, i;
  sg_io_hdr_t sg_io;
  unsigned char databuffer[256];
  unsigned char sensebuffer[SG_MAX_SENSE];

  fd = open("/dev/hdf", O_RDONLY);
  if (fd < 0) {
    printf("error: %s\n", strerror(errno));
    return(errno);
  }

  memset(&sg_io, 0, sizeof(sg_io));
  sg_io.interface_id = 'S';
  sg_io.dxfer_direction = SG_DXFER_FROM_DEV;
  sg_io.cmd_len = 10;
  sg_io.mx_sb_len = SG_MAX_SENSE;
  sg_io.dxfer_len = TOCLEN;
  sg_io.dxferp = databuffer;
  sg_io.cmdp = (unsigned char [10]){0x43, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, TOCLEN, 0x00};
  sg_io.sbp = sensebuffer;
  sg_io.timeout = 10*1000;

  ret = ioctl(fd, SG_IO, &sg_io);

  close(fd);
  return(0);
}


--
Giuliano.
