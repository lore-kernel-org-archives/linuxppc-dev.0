Message-ID: <40C58DF1.6030809@fh-landshut.de>
Date: Tue, 08 Jun 2004 11:59:13 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: VME driver change suggestion
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com> <40C48A1C.30602@fh-landshut.de>
In-Reply-To: <40C48A1C.30602@fh-landshut.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

To make the driver truly portable, it could be changed as follows:

1.) Add devices for the windows, similarly to the VMELinux.org driver:
Master windows:
     * /dev/m0  c 221 0
     * /dev/m1  c 221 1
     * /dev/m2  c 221 2
     * /dev/m3  c 221 3
     * /dev/m4  c 221 4
     * /dev/m5  c 221 5
     * /dev/m6  c 221 6
     * /dev/m7  c 221 7
Control window:
     * /dev/ctl c 221 8
Slave window:
     * /dev/s0  c 221 9
     * /dev/s1  c 221 10
     * /dev/s2  c 221 11
     * /dev/s3  c 221 12
     * /dev/s4  c 221 13
     * /dev/s5  c 221 14
     * /dev/s6  c 221 15
     * /dev/s7  c 221 16

(You've already partially matched that scheme with your ctl device)

2.) Implement read(), write() and llseek() for master and slave windows to
read/write values from/to the VME bus. Each would determine the master/slave
window read/written by determining the minor device number.

3.) Add ability to request specific windows back into ioctl, so mapping could be
associated with the proper devices.

4.) Include boundary checking in the read/write/llseek implementations
corresponding to their window values to avoid bad accesses "out of window".


read() and write () would use the vmemcpy() function I introduced earlier when
doing accesses to master windows.

Any ideas and suggestions towards this?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
