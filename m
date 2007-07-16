Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E015DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 09:20:25 +1000 (EST)
Subject: Re: [PATCH] adbhid: enable KEY_FN key reporting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aristeu Rozanski <aris@ruivo.org>
In-Reply-To: <20070716205309.GA30232@cathedrallabs.org>
References: <20070716205309.GA30232@cathedrallabs.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 09:20:17 +1000
Message-Id: <1184628018.25235.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 16:53 -0400, Aristeu Rozanski wrote:
> When a Fn key is used in combination with another key in ADB keyboards
> it will generate a Fn event and then a second event that can be a
> different key than pressed (Fn + F1 for instance can generate Fn +
> brightness down if it's configured like that). This patch enables the
> reporting of the Fn key to the input system.
> 
> As Fn is a dead key for most purposes, it's useful to report it so
> applications can make use of it. One example is apple_mouse
> (https://jake.ruivo.org/uinputd/trunk/apple_mouse/) that emulates the
> second and third keys using a combination of keyboard keys and the mouse
> button. Other applications may use the KEY_FN as a modifier aswell.
> I've been updating and using this patch for months without problems.
> 
> Signed-off-by: Aristeu Rozanski <aris@ruivo.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- linus-2.6.orig/drivers/macintosh/adbhid.c	2007-05-11 10:09:13.000000000 -0400
> +++ linus-2.6/drivers/macintosh/adbhid.c	2007-05-11 10:09:19.000000000 -0400
> @@ -70,7 +70,7 @@
>  #define ADB_KEY_POWER_OLD	0x7e
>  #define ADB_KEY_POWER		0x7f
>  
> -u8 adb_to_linux_keycodes[128] = {
> +u16 adb_to_linux_keycodes[128] = {
>  	/* 0x00 */ KEY_A, 		/*  30 */
>  	/* 0x01 */ KEY_S, 		/*  31 */
>  	/* 0x02 */ KEY_D,		/*  32 */
> @@ -134,7 +134,7 @@
>  	/* 0x3c */ KEY_RIGHT,		/* 106 */
>  	/* 0x3d */ KEY_DOWN,		/* 108 */
>  	/* 0x3e */ KEY_UP,		/* 103 */
> -	/* 0x3f */ 0,
> +	/* 0x3f */ KEY_FN,		/* 0x1d0 */
>  	/* 0x40 */ 0,
>  	/* 0x41 */ KEY_KPDOT,		/*  83 */
>  	/* 0x42 */ 0,
> @@ -208,7 +208,7 @@
>  	int original_handler_id;
>  	int current_handler_id;
>  	int mouse_kind;
> -	unsigned char *keycode;
> +	u16 *keycode;
>  	char name[64];
>  	char phys[32];
>  	int flags;
> @@ -275,7 +275,7 @@
>  adbhid_input_keycode(int id, int keycode, int repeat)
>  {
>  	struct adbhid *ahid = adbhid[id];
> -	int up_flag;
> +	int up_flag, key;
>  
>  	up_flag = (keycode & 0x80);
>  	keycode &= 0x7f;
> @@ -321,8 +321,7 @@
>  			}
>  		} else
>  			ahid->flags |= FLAG_FN_KEY_PRESSED;
> -		/* Swallow the key press */
> -		return;
> +		break;
>  	case ADB_KEY_DEL:
>  		/* Emulate Fn+delete = forward delete */
>  		if (ahid->flags & FLAG_FN_KEY_PRESSED) {
> @@ -336,9 +335,9 @@
>  #endif /* CONFIG_PPC_PMAC */
>  	}
>  
> -	if (adbhid[id]->keycode[keycode]) {
> -		input_report_key(adbhid[id]->input,
> -				 adbhid[id]->keycode[keycode], !up_flag);
> + 	key = adbhid[id]->keycode[keycode];
> + 	if (key) {
> + 		input_report_key(adbhid[id]->input, key, !up_flag);
>  		input_sync(adbhid[id]->input);
>  	} else
>  		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
> @@ -757,8 +756,8 @@
>  		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
>  		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
>  		input_dev->event = adbhid_kbd_event;
> -		input_dev->keycodemax = 127;
> -		input_dev->keycodesize = 1;
> +		input_dev->keycodemax = KEY_FN;
> +		input_dev->keycodesize = sizeof(hid->keycode[0]);
>  		break;
>  
>  	case ADB_MOUSE:
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
