Message-Id: <200212091221.GAA14020@lists.linuxppc.org>
Date: Mon, 9 Dec 2002 20:29:7 +0800
From: "Li Xiangrong" <lixiangrong@china.com>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: boot flash problem,
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Jean-Denis Boyer,

Thank u for ur advice, but i am afraid it is not of flash base address.
Formerly i used a 16Mb flash of intel te28f160c3ba90, which works without any problem. Then i changed the flash to a bigger one, intel te28f320b3ba110. Both time, i set the base address 0xffe00000, which means i can use a flash of 2M words here.As i use a 16-bit flash, it's okay for 28f320. Further more, i can erase, prog and verify the flash. So i think there is no problem with the setting of flash base address.
As i had said, my board works okay with the flash of te28f160c3ba90. However, when i changed it to te28f320b3ba110,the ppc860t can not boot up. I checked the clock and found it's 25MHz (I used a 5MH clock in here and set the mf=5). I doubted that the boot program in flash didn't work at all.
I traced the ppcboot with my bdi2000. It worked well with the bdi.I traced with single step and went with the break point. It's okay. I used the instruction "go" and there cames the familiar infomation of ppcboot in minicom. Then i checked the cs0 and bs0. I found bs0 kept low and there cames a periodic pulse ( a pure periodic signal) output on cs0. The frequency of the cs0 is about 670KHz,which kept high about 300ns and low about 1200ns.According to the user menu of mpc860: when booting us, the gpcm asserts cs0# for every address except internal register, and the 860 sets scy[0:3] 1111 and trlx 1, which means that ppc reads the memory within 32 clock cycles (32 *40ns =1200 ns).I suppose that after reset, ppc860 reads the flash but it can not get the entry of start.s. So it kept reading the flash. But how can this come? Since the program works okay when it in a 16MB flash and even in a 32MB flash (with the control of bdi). How can this happen? Is there something special need 
 t!
o attention at?
I am now fully confused and hope u can give me any suggestion. Thanks in advance.



= = = = = = = = = = = = = = = = = = = =


Best regards.
Li Xiangrong
lixiangrong@china.com
2002-12-09

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
