Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 02472DDEE9
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 21:10:09 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Sat, 7 Mar 2009 11:09:48 +0100
References: <ae4f76fd0902200151m461f9336x1e2bbec61f815fde@mail.gmail.com>
In-Reply-To: <ae4f76fd0902200151m461f9336x1e2bbec61f815fde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903071109.49726.jbe@pengutronix.de>
Subject: Re: Davicom DM9000A on MPC5200B (powerpc) works using a dirty
	offsetting and byte trick
Cc: Henk Stegeman <henk.stegeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Henk,

On Freitag, 20. Februar 2009, Henk Stegeman wrote:
> - Any suggestions to what could be wrong here? Or does the MPC5200 in
> this case only byte swap u16 reads, but a u8 read is unchanged?

You should not follow the Freescale bus signal names when you connect your 
external little endian device. Otherwise the offsets are always wrong.

Do it in this way instead:

    MPC          LE Device
  D[0..7]   <->  D[24..31]
  D[8..15]  <->  D[16..23]
  D[16..23] <->  D[8..15]
  D[24..31] <->  D[0..7]

If you connect your device in such a way, just enable CS's byte swap feature 
depending on your bus size and you are done (no additional software 
manipulation required). Now you can write bytes, words or longs and you will 
always write the correct data into the corresponding device register.

Hope it helps
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
