From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Martin Costabel <costabel@wanadoo.fr>, Paul.Mackerras@cs.anu.edu.au
Subject: Re: vger-2.3.15 on pmac
Date: Fri, 27 Aug 1999 03:01:53 +0200
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <4.2.0.58.19990826171730.00981650@mail.lauterbach.com> <37C57094.D6415E54@wanadoo.fr> <99082700153800.01224@ns1102.munich.netsurf.de>
In-Reply-To: <99082700153800.01224@ns1102.munich.netsurf.de>
MIME-Version: 1.0
Message-Id: <99082703052100.00447@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Fre, 27 Aug 1999 schrieb Franz Sirl:
>- convert adb_mouse_setup to new style (compiles, but not tested yet)

AAARGH! Everything has changed with the setup code. Use the following diff
for the adb_mouse_setup routine:

@@ -174,16 +193,22 @@ __initfunc(int adb_mouse_init(void))
  * option, which is about using ADB keyboard buttons to emulate
  * mouse buttons. -- paulus
  */
-__initfunc(void adb_mouse_setup(char *str, int *ints))
+static int __init adb_mouse_setup(char *str)
 {
+       int ints[4];
+
+       str = get_options(str,ARRAY_SIZE(ints),ints);
        if (ints[0] >= 1) {
-               adb_emulate_buttons = ints[1] > 0;
-               if (ints[1] > 1)
-                       adb_button2_keycode = ints[1];
+               adb_emulate_buttons = ints[1];
                if (ints[0] >= 2)
-                       adb_button3_keycode = ints[2];
+                       adb_button2_keycode = ints[2];
+               if (ints[0] >= 3)
+                       adb_button3_keycode = ints[3];
        }
+       return 1;
 }
+
+__setup("adb_buttons=", adb_mouse_setup);

 #ifdef MODULE
 int init_module(void)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
