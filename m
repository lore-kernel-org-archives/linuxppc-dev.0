Message-Id: <l03110700b5e1ca17f60e@[212.11.30.213]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 11 Sep 2000 02:22:59 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Etienne Herlent <eherlent@easynet.fr>
Subject: Emulating button 3 on 2 button ADB mice 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This is a follow up to a message post on Fri, 25 Aug 2000 21:10:25 +1000
(EST) with the same title by Malcolm Purvis. I am having the same problem
with a 2 button Kensington mouse on my Macintoshes, but with Xpmac not
Xfree.

Here are my experiment.

hardware/software :
- G3/266/beige/Rev1 with ADB Kensington mouse with 2 buttons (I will name
it KM2), kernel 2.2.17 downloaded at ftp://ftp.kernel.org, compiled my
self, Xpmac.rage128.usb.rev9
- 6500/275 with ADB Kensington mouse with 4 buttons (it's a Thinking Mouse,
I will name it KM4), same kernel, Xpmac.rage128.usb.rev9.

The 2 mice are known as Turbo Mouse 5 by the kernel.

the symptoms :
- on the G3, it's impossible to have the third button emulated by a chord,
while it worked with a 2.2.10 kernel. In fact, this problem appeared when I
tried the 2.2.12 kernel some months ago.
- on the 6500 : all work fine.
If I switch round the 2 mice, the problem appear on the 6500 and all work
fine on the G3. This problem seams to be linked to KM2.

investigations :
here the init_turbomouse function from drivers/macintosh/mac_keyb.c :
static void init_turbomouse(int id)
{
	struct adb_request req;

	printk(" (TurboMouse 5)");
	adb_mouse_kinds[id] = ADBMOUSE_TURBOMOUSE5;
	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(3));
	adb_request(&req, NULL, ADBREQ_SYNC, 9, ADB_WRITEREG(3,2), 0xe7, 0x8c,
0, 0, 0, 0xff, 0xff, 0x94);
	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(3));
	adb_request(&req, NULL, ADBREQ_SYNC, 9, ADB_WRITEREG(3,2), 0xa5, 0x14,
0, 0, 0x69, 0xff, 0xff, 0x27);
}

I replaced the "3" in the calls to ADB_FLUSH and ADB_WRITEREG by "id".
Then, the third button is emulated by a chord.

But a new bug appear : there is a delay beetween a click and the time it is
detected. For example, if, moving the mouse, I click on a title bar of a
window, I miss it ! This appear with KM2 and KM4.

I made the same expirements and noticings on the 2.2.17pre20-ben3 kernel
with Xpmac.rev10 on the G3 with KM2.

So, on the 2.2.17pre20-ben3 kernel, I replaced the init_turbomouse function
by what was in the 2.2.10 kernel :
static void init_turbomouse(int id)
{
   struct adb_request req;

   printk(" (TurboMouse 5)");
   adb_mouse_kinds[id] = ADBMOUSE_TURBOMOUSE5;
   adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
   adb_request(&req, NULL, ADBREQ_SYNC, 3, ADB_WRITEREG(id,3), 0x20 | id, 4);
   adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
   adb_request(&req, NULL, ADBREQ_SYNC, 9, ADB_WRITEREG(id,2), 0xe7, 0x8c,
0, 0, 0, 0xff, 0xff, 0x94);
   adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
   adb_request(&req, NULL, ADBREQ_SYNC, 9, ADB_WRITEREG(id,2), 0xa5, 0x14,
0, 0, 0x69, 0xff, 0xff, 0x27);
}

The third button is correctly emulated, but there is always the delay on
the clicks with KM2 (I didn't try with KM4). I can't remember if there was
a delay with the 2.2.10 kernel (and I don't have this kernel anymore).

(Note to BenH : I have tried this since my last message to you.)

I don't know how ADB work, so I don't know what to do to fix the problem.
Any ideas someone ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
