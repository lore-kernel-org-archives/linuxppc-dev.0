From: Graf Alex <alex.graf@siemens.com>
To: "'Song Sam'" <samlinuxppc@yahoo.com.cn>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36ECA@chzugexch01.abatos.com>
Subject: AW: How to set current time to 8xx RTC through Linux application?
Date: Fri, 11 Jun 2004 08:41:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you did implement the Linux rtc interface, you should be able to
read/write the time with IOCTLs from your app.

fRtc = open("/dev/rtc", O_RDWR, 0);
ioctl(fRtc, RTC_RD_TIME, &tm );
ioctl(fRtc, RTC_SET_TIME, &tm);

Be carefull, System time is NOT equal RTC time! You have to sync it
periodical.

Cheers

Alex


-----Ursprüngliche Nachricht-----
Von: Song Sam [mailto:samlinuxppc@yahoo.com.cn]
Gesendet: Mittwoch, 9. Juni 2004 15:14
An: Linuxppc-Embedded
Cc: samlinuxppc@yahoo.com.cn
Betreff: How to set current time to 8xx RTC through Linux application?



Hi,

I added 8xx RTC driver both on U-Boot and Linux
kernel.And I could set current time right under
U-Boot.But I have no idea on making it through Linux
application?I could read it with following code but
how to set it?

#include <time.h>

     time_t t;
     struct tm * tm;

     time(&t);
     tm=localtime(&t);

     printf("\nThe corrent time is : %02d.%02d.%02d
%02d:%02d:%02d\n",tm->tm_year+1900,tm->tm_mon+1,tm->tm_mday,tm->tm_hour,tm->
tm_min,tm->tm_sec);

Thanks in advance!

Sam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
