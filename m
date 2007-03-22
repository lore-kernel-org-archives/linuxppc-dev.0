Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [204.127.192.85])
	by ozlabs.org (Postfix) with ESMTP id 8C475DDED0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:37:34 +1100 (EST)
Message-ID: <4601DDD4.2030105@comcast.net>
Date: Wed, 21 Mar 2007 21:37:24 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: libfdt: going forward for u-boot
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
	<4601D7FF.1080801@comcast.net>
	<20070322012507.GF2295@localhost.localdomain>
In-Reply-To: <20070322012507.GF2295@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Mar 21, 2007 at 09:12:31PM -0400, Jerry Van Baren wrote:
>> David Gibson wrote:

[snip]

>>>> fdt_rw.c
>>>> --------
>>>> * Nonessential improvements to fdt_open_into()
>>>>   * Validate the header (fdt_move() does the validation, but I skip
>>>>       the move if buf == fdt so I needed to add the validation)
>>>>   * Do the fdt_move() only if (buf != fdt) - I call this at times with
>>>>       a new (longer) length but don't want to actually move the blob,
>>>>       just want the longer length so I can modify the fdt in-place.  The
>>>>       current code works, but it seemed silly to do a move if I'm not
>>>>       actually moving it.
>>> If fdt == buf, the memmove() in fdt_move() will become a no-op in any
>>> case.  I don't see any point to conditionalizing the fdt_move().
>> But it allows me to make the blob bigger.  Ahh, it looks like all I need 
>> to do is:
>>          fdt_set_header(fdt, totalsize, bufsize);
>> so I agree, I'm working way too hard on this one.
> 
> No, if you want to make more space to do edits in, you should
> definitely be using fdt_open_into() - that's the purpose of
> fdt_open_into().  I'm just saying there's no need to conditionalize
> the fdt_move(), because fdt_move() *already* correctly handles the
> case where fdt==buf.

Not in my copy unless the memmove() implementation counts.
--------------------------------
int fdt_move(const void *fdt, void *buf, int bufsize)
{
         int err = _fdt_check_header(fdt);

         if (err)
                 return err;

         if (fdt_totalsize(fdt) > bufsize)
                 return -FDT_ERR_NOSPACE;

         memmove(buf, fdt, fdt_totalsize(fdt));
         return 0;
}
--------------------------------
--- a/fdt_rw.c
+++ b/fdt_rw.c
@@ -260,11 +260,19 @@ int fdt_del_node(void *fdt, int nodeoffset)

  int fdt_open_into(void *fdt, void *buf, int bufsize)
  {
-       int err;
-
-       err = fdt_move(fdt, buf, bufsize);
-       if (err)
-               return err;
+        int err = rw_check_header(fdt);
+
+        if (err)
+                return err;
+
+       /*
+        * If we are just expanding the size in-place, no need to do the 
move.
+        */
+       if (buf != fdt) {
+               err = fdt_move(fdt, buf, bufsize);
+               if (err)
+                       return err;
+       }

         fdt = buf;

--------------------------------
(Yes, the above is whitespace damaged.  It ain't a patch ;-)

Best regards,
gvb
