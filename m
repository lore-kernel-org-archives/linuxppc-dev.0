Return-Path: <aris@cathedrallabs.org>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id C6E6D67B52
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 23:44:27 +1000 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8KDiPCu021535
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:25 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8KDiPSo003771
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:25 -0400
Received: from localhost.localdomain (vpn-51-24.sfbay.redhat.com [10.14.51.24]
	(may be forged))
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k8KDiMhR015133
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:23 -0400
Received: from aris by localhost.localdomain with local (Exim 4.63)
	(envelope-from <aris@cathedrallabs.org>) id 1GQ2N2-0000lu-Uz
	for linuxppc-dev@ozlabs.org; Wed, 20 Sep 2006 10:44:13 -0300
Date: Wed, 20 Sep 2006 10:44:12 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] adbhid: enable KEY_FN key reporting
Message-ID: <20060920134412.GA23803@cathedrallabs.org>
References: <20060808154117.GA3363@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060808154117.GA3363@cathedrallabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch enables the KEY_FN reporting on ADB based machines. This is a
> needed step to move special key sequences handling to user space and to
> allow the usage of Fn key to other purposes. I've been running this for
> some days without problems.
> 
> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>
any comments on this one?

> Index: ppc-2.6/drivers/macintosh/adbhid.c
> ===================================================================
> --- ppc-2.6.orig/drivers/macintosh/adbhid.c	2006-08-04 08:53:20.000000000 -0300
> +++ ppc-2.6/drivers/macintosh/adbhid.c	2006-08-04 09:45:43.000000000 -0300
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
>  adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
>  {
>  	struct adbhid *ahid = adbhid[id];
> -	int up_flag;
> +	int up_flag, key;
>  
>  	up_flag = (keycode & 0x80);
>  	keycode &= 0x7f;
> @@ -322,8 +322,7 @@
>  			}
>  		} else
>  			ahid->flags |= FLAG_FN_KEY_PRESSED;
> -		/* Swallow the key press */
> -		return;
> +		break;
>  	case ADB_KEY_DEL:
>  		/* Emulate Fn+delete = forward delete */
>  		if (ahid->flags & FLAG_FN_KEY_PRESSED) {
> @@ -337,10 +336,10 @@
>  #endif /* CONFIG_PPC_PMAC */
>  	}
>  
> -	if (adbhid[id]->keycode[keycode]) {
> +	key = adbhid[id]->keycode[keycode];
> +	if (key) {
>  		input_regs(adbhid[id]->input, regs);
> -		input_report_key(adbhid[id]->input,
> -				 adbhid[id]->keycode[keycode], !up_flag);
> +		input_report_key(adbhid[id]->input, key, !up_flag);
>  		input_sync(adbhid[id]->input);
>  	} else
>  		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
> @@ -764,8 +763,8 @@
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

-- 
Aristeu
