Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 1910068819
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Nov 2005 18:41:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Nov 2005 08:41:22 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD152557@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: do_initcalls
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

In linux-2.4.25/init/main.c this function is called:
=09
	static void __init do_initcalls(void)
	{
		initcall_t *call;
=09
		call =3D &__initcall_start;
		do {
			(*call)();
			call++
		} while (call < &__initcall_end);

		/* Make sure there is no pending stuff from the initcall
sequence */
		flush_scheduled_tasks();
	}

What is supposed to be in the section __initcall_start ..
__initcall_end?
Mine is empty and therefore causing trouble...
System.map:
	//
	//
	c00ad880 A __initcall_end
	c00ad880 A __initcall_start
	//
	//

The fix is obvious... But I guess I've missed something else?

Thanks in advance,
	Jaap de Jong
=09
