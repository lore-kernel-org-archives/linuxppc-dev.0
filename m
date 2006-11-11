Return-Path: <kallepokki@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 4E87C68026
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Nov 2006 01:15:25 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so532909pyb
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Nov 2006 06:15:21 -0800 (PST)
Message-ID: <a425f86c0611110615r5b5d1daeydd6007a657548f96@mail.gmail.com>
Date: Sat, 11 Nov 2006 16:15:19 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <17749.46096.241328.470093@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
	<a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
	<Pine.LNX.4.64.0611101359200.25024@host32.eke.fi>
	<17749.46096.241328.470093@cargo.ozlabs.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/11/06, Paul Mackerras <paulus@samba.org> wrote:
> Kalle Pokki writes:
>
> > Hmm, it seems you already pushed the changes. This should apply to the
> > current 'merge' branch.
>
> That on its own is hard to justify as a bug fix, isn't it?

Sure, but since you removed the last hunk of the patch that became
0091cf5a6ae6e52fc95ceb53200975ef2c81c206, we now have a little
inconsistent definitions:

in cpm_uart.h
int __init cpm_uart_init_portdesc(void);

in cpm_uart_cpm1.c
int __init cpm_uart_init_portdesc(void)
{
}

in cpm_uart_cpm2.c
int cpm_uart_init_portdesc(void)
{
}
