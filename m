Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17864.60804.657656.535779@cargo.ozlabs.ibm.com>
Date: Wed, 7 Feb 2007 08:05:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 0/11] Patches for Toshiba Cell reference set
In-Reply-To: <200702061301.l16D1lxf009347@toshiba.co.jp>
References: <1170633321.2620.56.camel@localhost.localdomain>
	<200702061301.l16D1lxf009347@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou writes:

> We found that following phenomenon:
>  - An application calls "munmap"
>  - do_munmap flushes TLB (so HTAB is invalidated)
>  - when exiting spin_unlock(), DEC exception occurs. (!)
>  - One of DEC handler causes data storage interrupt

Interesting.  Did you find out exactly what was causing the DSI in the
decrementer interrupt handling?  It sounds like that is the real bug.

Paul.
