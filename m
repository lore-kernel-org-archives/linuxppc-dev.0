Subject: RE: jumbled characters on serial port
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 27 Jun 2003 11:47:55 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED703039B@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would suggest you write yourself a kind of "safe_printk" (over printk) that filters characters that can not be displayed, and then use that function in your code. It is, IMHO, easier to fix the problem there than losing the tty and/or the terminal emulator. You can even hack directly the printk function (kernel/printk.c:412) and add a filter just after the call to vsnprintf.

Regards,
--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------


> -----Original Message-----
> From: Omanakuttan [mailto:omanakuttan@tataelxsi.co.in]
> Sent: 27 juin, 2003 11:31
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: jumbled characters on serial port
>
>
>
> Hi,
> We have developed MCC drivers for mpc8260. For debugging the driver we
> have put several printk in the code. Since the data is not
> ascii all the
> time, sometimes the screen gets fully jumbled characters. I understand
> that printing some binary data causes this.
> We are using minicom and busybox .60.5. If anybody knows how
> to get the
> characters back, please advise.
> We tried closing down the minicom window and restarting minicom. This
> does not help. More over we are getting jumbled chars, not secondary
> font. (if I were running bash, i would have run `reset`. But I never
> faced this in i386)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
