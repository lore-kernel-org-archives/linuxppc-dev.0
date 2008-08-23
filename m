Return-Path: <liuxs226@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 85DC6DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 13:19:05 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so1043821qbd.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 20:19:03 -0700 (PDT)
Message-ID: <e81b2fb40808222019hd8b7eb9va649b0771ed83f49@mail.gmail.com>
Date: Sat, 23 Aug 2008 11:19:02 +0800
From: "=?GB2312?B?wfXQocur?=" <liuxs226@gmail.com>
To: linuxppc-embedded@ozlabs.org, directfb-dev@directfb.org
Subject: no output on screen
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_35774_2149366.1219461542964"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_35774_2149366.1219461542964
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi, all
I am writing a gfxdriver for Fujitsu mb86296 video card under DirectFB. When
I run a example df_fire from DirectFB-examples-1.0.0.tar.gz, there is  no
output on the computer screen, it is black completely, and the error result
looks like this:

sh-3.00# ./df_fire

     =======================|  DirectFB 1.0.0  |=======================
          (c) 2001-2007  The DirectFB Organization (directfb.org)
          (c) 2000-2004  Convergence (integrated media) GmbH
        ------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2008-06-03 03:01) [ TRACE ]
(*) Direct/Memcpy: Using ppcasm_memcpy()
(*) Direct/Thread: Running 'VT Switcher' (CRITICAL, 502)...
(*) Direct/Thread: Running 'PS/2 Input' (INPUT, 503)...
(*) DirectFB/Input: IMPS/2 Mouse 1.0 (directfb.org)
(*) Direct/Thread: Running 'Keyboard Input' (INPUT, 504)...
(*) DirectFB/Input: Keyboard 0.9 (directfb.org)
(*) DirectFB/Graphics: Fujitsu MB86296 0.5 (Atom Create)
(!) [  493:    0.000] --> Caught signal 11 (at (nil), invalid address) <--
(-) [  493: -STACK- ]
  #0  0x0fecef48 in signal_handler () from
/mnt/gtkdfb/lib/libdirect-1.0.so.0
[0xfec4000]
  #1  0x0ffc5b40 in dfb_screens_initialize () from
/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]
  #2  0x0ffb3520 in dfb_core_part_initialize () from
/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]
  #3  0x0ffb2edc in dfb_core_arena_initialize () from
/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]
  #4  0x0ffb2edc in dfb_core_arena_initialize () from
/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]
  #5  0x0ff029f8 in fusion_arena_enter () from
/mnt/gtkdfb/lib/libfusion-1.0.so.0 [0xfeff000]
  #6  0x0ffb18f4 in dfb_core_create () from
/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]
  #7  0x100127b4 in DirectFBCreate () from ./df_fire [0x10000000]

(-) [  502: -STACK- 'VT Switcher']
  #0  0x0fcf3970 in vt_thread () from
/mnt/gtkdfb/lib/directfb-1.0-0/systems/libdirectfb_fbdev.so [0xfcea000]

(-) [  503: -STACK- 'PS/2 Input']
  #0  0x0fba6c88 in ps2mouseEventThread () from
/mnt/gtkdfb/lib/directfb-1.0-0/inputdrivers/libdirectfb_ps2mouse.so
[0xfba4000]

(-) [  504: -STACK- 'Keyboard Input']
  #0  0x0fc56e84 in keyboardEventThread () from
/mnt/gtkdfb/lib/directfb-1.0-0/inputdrivers/libdirectfb_keyboard.so
[0xfc55000]

Aborted

I wonder if it is wrong in my code in mb86296_screen.c which I refer to
sh7722 gfxdriver, here is the code:

/**********************************************************************************************************************/

static DFBResult
mb86296InitScreen( CoreScreen           *screen,
               CoreGraphicsDevice       *device,
               void                 *driver_data,
               void                 *screen_data,
               DFBScreenDescription *description )
{
          /* Set the screen capabilities. */
     description->caps = DSCCAPS_NONE;

     /* Set the screen name. */
     snprintf( description->name, DFB_SCREEN_DESC_NAME_LENGTH, "MB86296
Screen" );

     return DFB_OK;
}

static DFBResult
mb86296GetScreenSize( CoreScreen *screen,
                  void       *driver_data,
                  void       *screen_data,
                  int        *ret_width,
                  int        *ret_height )
{
     *ret_width  = MB86296_LCD_WIDTH;
     *ret_height = MB86296_LCD_HEIGHT;

     return DFB_OK;
}

ScreenFuncs mb86296ScreenFuncs = {
     InitScreen:    mb86296InitScreen,
     GetScreenSize: mb86296GetScreenSize
};

In driver_init_driver(), I called dfb_screens_register( device, driver_data,
&mb86296ScreenFuncs ).

anybody can help me??

------=_Part_35774_2149366.1219461542964
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi, all</div>
<div>I am writing a gfxdriver for Fujitsu mb86296 video card under DirectFB. When I run a example df_fire from DirectFB-examples-1.0.0.tar.gz, there is&nbsp; no output on the computer screen, it is black completely, and the error result looks like this:</div>

<div>
<p>sh-3.00# ./df_fire</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; =======================|&nbsp; DirectFB 1.0.0&nbsp; |=======================<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (c) 2001-2007&nbsp; The DirectFB Organization (<a href="http://directfb.org">directfb.org</a>)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (c) 2000-2004&nbsp; Convergence (integrated media) GmbH<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------------------------------------------------------</p>
<p>(*) DirectFB/Core: Single Application Core. (2008-06-03 03:01) [ TRACE ]<br>(*) Direct/Memcpy: Using ppcasm_memcpy()<br>(*) Direct/Thread: Running &#39;VT Switcher&#39; (CRITICAL, 502)...<br>(*) Direct/Thread: Running &#39;PS/2 Input&#39; (INPUT, 503)...<br>
(*) DirectFB/Input: IMPS/2 Mouse 1.0 (<a href="http://directfb.org">directfb.org</a>)<br>(*) Direct/Thread: Running &#39;Keyboard Input&#39; (INPUT, 504)...<br>(*) DirectFB/Input: Keyboard 0.9 (<a href="http://directfb.org">directfb.org</a>)<br>
(*) DirectFB/Graphics: Fujitsu MB86296 0.5 (Atom Create)<br>(!) [&nbsp; 493:&nbsp;&nbsp;&nbsp; 0.000] --&gt; Caught signal 11 (at (nil), invalid address) &lt;--<br>(-) [&nbsp; 493: -STACK- ]<br>&nbsp; #0&nbsp; 0x0fecef48 in signal_handler () from /mnt/gtkdfb/lib/libdirect-1.0.so.0<br>
[0xfec4000]<br>&nbsp; #1&nbsp; 0x0ffc5b40 in dfb_screens_initialize () from<br>/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]<br>&nbsp; #2&nbsp; 0x0ffb3520 in dfb_core_part_initialize () from<br>/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]<br>
&nbsp; #3&nbsp; 0x0ffb2edc in dfb_core_arena_initialize () from<br>/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]<br>&nbsp; #4&nbsp; 0x0ffb2edc in dfb_core_arena_initialize () from<br>/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]<br>&nbsp; #5&nbsp; 0x0ff029f8 in fusion_arena_enter () from<br>
/mnt/gtkdfb/lib/libfusion-1.0.so.0 [0xfeff000]<br>&nbsp; #6&nbsp; 0x0ffb18f4 in dfb_core_create () from<br>/mnt/gtkdfb/lib/libdirectfb-1.0.so.0 [0xff5f000]<br>&nbsp; #7&nbsp; 0x100127b4 in DirectFBCreate () from ./df_fire [0x10000000]</p>
<p>(-) [&nbsp; 502: -STACK- &#39;VT Switcher&#39;]<br>&nbsp; #0&nbsp; 0x0fcf3970 in vt_thread () from<br>/mnt/gtkdfb/lib/directfb-1.0-0/systems/libdirectfb_fbdev.so [0xfcea000]</p>
<p>(-) [&nbsp; 503: -STACK- &#39;PS/2 Input&#39;]<br>&nbsp; #0&nbsp; 0x0fba6c88 in ps2mouseEventThread () from<br>/mnt/gtkdfb/lib/directfb-1.0-0/inputdrivers/libdirectfb_ps2mouse.so<br>[0xfba4000]</p>
<p>(-) [&nbsp; 504: -STACK- &#39;Keyboard Input&#39;]<br>&nbsp; #0&nbsp; 0x0fc56e84 in keyboardEventThread () from<br>/mnt/gtkdfb/lib/directfb-1.0-0/inputdrivers/libdirectfb_keyboard.so<br>[0xfc55000]</p>
<p>Aborted</p>
<p>I wonder if it is wrong in my code in mb86296_screen.c which I refer to sh7722 gfxdriver, here is the code:</p>
<p>/**********************************************************************************************************************/</p>
<p>static DFBResult<br>mb86296InitScreen( CoreScreen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *screen,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CoreGraphicsDevice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *device,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_data,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *screen_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DFBScreenDescription *description )<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set the screen capabilities. */<br>&nbsp;&nbsp;&nbsp;&nbsp; description-&gt;caps = DSCCAPS_NONE;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; /* Set the screen name. */<br>&nbsp;&nbsp;&nbsp;&nbsp; snprintf( description-&gt;name, DFB_SCREEN_DESC_NAME_LENGTH, &quot;MB86296 Screen&quot; );</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; return DFB_OK;<br>}</p>
<p>static DFBResult<br>mb86296GetScreenSize( CoreScreen *screen,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_data,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *screen_data,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ret_width,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ret_height )<br>
{<br>&nbsp;&nbsp;&nbsp;&nbsp; *ret_width&nbsp; = MB86296_LCD_WIDTH;<br>&nbsp;&nbsp;&nbsp;&nbsp; *ret_height = MB86296_LCD_HEIGHT;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; return DFB_OK;<br>}</p>
<p>ScreenFuncs mb86296ScreenFuncs = {<br>&nbsp;&nbsp;&nbsp;&nbsp; InitScreen:&nbsp;&nbsp;&nbsp; mb86296InitScreen,<br>&nbsp;&nbsp;&nbsp;&nbsp; GetScreenSize: mb86296GetScreenSize<br>};</p>
<p>In driver_init_driver(), I called dfb_screens_register( device, driver_data, &amp;mb86296ScreenFuncs ).</p>
<p>anybody can help me??<br></p>
<p>&nbsp;</p></div>

------=_Part_35774_2149366.1219461542964--
