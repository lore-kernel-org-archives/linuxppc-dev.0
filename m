Message-ID: <3FC537B5.80504@g-house.de>
Date: Thu, 27 Nov 2003 00:31:01 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT] de2104x fixes])
References: <20031126203131.GJ2541@stop.crashing.org>
In-Reply-To: <20031126203131.GJ2541@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> Ok, here's a better patch.  It's against 2.6.0-test9-BK-latest
> (currently bk25).

[...]

i don't have a -bk tree here, so i get a .rej with -test9 and -test10:

evil@sheep:/usr/src/linux-2.6$ cat /data/Incoming/de2104x.c.diff |  \
patch -p1 --dry-run
patching file drivers/net/tulip/de2104x.c
Hunk #6 FAILED at 1569.
1 out of 7 hunks FAILED -- saving rejects to file
drivers/net/tulip/de2104x.c.rej
evil@sheep:/usr/src/linux-2.6$


so, drivers/net/tulip/de2104x.c.rej contains:


***************
*** 1571,1583 ****
             (ecmd->advertising == de->media_advertise))
                 return 0; /* nothing to change */

-       de_link_down(de);
-       de_stop_rxtx(de);

         de->media_type = new_media;
         de->media_lock = media_lock;
         de->media_advertise = ecmd->advertising;
-       de_set_media(de);

         return 0;
   }
--- 1569,1585 ----
             (ecmd->advertising == de->media_advertise))
                 return 0; /* nothing to change */

+       if (netif_running(dev)) {
+               de_link_down(de);
+               de_stop_rxtx(de);
+       }

         de->media_type = new_media;
         de->media_lock = media_lock;
         de->media_advertise = ecmd->advertising;
+
+       if (netif_running(dev))
+               de_set_media(de);

         return 0;
   }
-------------------------------------------



it takes a while to compile....

Christian.
--
BOFH excuse #20:

divide-by-zero error


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
