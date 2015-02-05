Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CC4D1A0AD3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 15:52:47 +1100 (AEDT)
Received: by mail-ig0-f171.google.com with SMTP id h15so23600373igd.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 20:52:43 -0800 (PST)
Message-ID: <54D2F719.7020405@gmail.com>
Date: Wed, 04 Feb 2015 23:52:41 -0500
From: nick <xerofoify@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Question about the function,andslcd_ioctl in the file,ans-lcd.c
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings Benjamin and others,
I am wondering why this code has not been removed:
 for (; ch; temp++) { /* FIXME: This is ugly, but should work, as a \0 byte is not a valid command code */
                        anslcd_write_byte_ctrl ( ch );
                         __get_user(ch, temp);
                }
As if we don't want to run a command code then why not break out of the case and 
remove this loop as there is no need for it if we don't need to execute the call
to the function, anslcd_write_byte_ctrl to write the command code. Unless I am 
missing something, I am assuming I can send in a patch removing this lines of 
code.
Cheers Nick
