Message-ID: <3B586C25.C0575C88@mvista.com>
Date: Fri, 20 Jul 2001 10:36:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ATTN: todc_time.c users
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shortly, I will be pushing some changes to the todc files.  Basically,
I've macro-ized the tables that are currently in todc_time.c.  What this

means to you is:

1) In your xxx_setup.c file, use the new TODC_DECL() macro to
define and initialize a todc_info_t structure.  For example, if you're
using a mc146818 rtc, put TODC_DECL(TODC_TYPE_MC146818); somewhere in
your xxx_setup.c file.

2) In your xxx_setup.c file, get rid of the "todc_info = yyy;" line.

3) If you happen to use a mc146818, you need to add the following lines
to your xxx_init() routine in your xxx_setup.c file (unless you are
alread overriding the default values):

     todc_info->nvram_as0  = (u_char *)0x70;
     todc_info->nvram_data = (u_char *)0x71;

4) To add support for a new clock, you add macros in todc.h instead of a

structure in todc_time.c

These changes get rid of all the structures in todc_time.c that are
mostly wasting space.

I have made the appropriate changes to the xxx_setup.c files that are in
2_4_devel,
and tested the sandpoint and mcpn765.  If you use the todc facility you
should make the appropriate changes and test.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
