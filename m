Message-ID: <20030823001513.28591.qmail@web21414.mail.yahoo.com>
Date: Fri, 22 Aug 2003 17:15:13 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
Subject: more info on kernel BUG at page_alloc.c:225
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I should have said my version of linux2.4.19 is
ppc440GP port, so the line number is line 220 in
original linux 2.4.19 from kernel.org website. Be
clear, I printed the lines which panic occured:

219->      if (PageLRU(page))
220->          BUG();


-----------------------------------------------
I searched the web, following is the patch I am
interested. Can it solve the above problem?

On 02:39, venerdì 18 ottobre 2002, Gadad, Vijay wrote:
> I'm seeing an intermittent oops on a heavily loaded
SMP system (Compaq
> DL360 G2).  I've read the messages suggesting this
is related to the nvidia
> driver, but I don't have that loaded.
>
> This is the vanilla 2.4.19 kernel, plus Intel's
e1000.o driver and the ipvs
> patch.
>
> Here's the ksymoops output:
>
> kernel BUG at page_alloc.c:220!
> invalid operand: 0000
> CPU:    1
> EIP:    0010:[rmqueue+509/592]    Not tainted

this may be a patch:

[albert@yoda albert]$ diff -ruN page_alloc.c
new_page_alloc.c
--- page_alloc.c
+++ new_page_alloc.c
@@ -167,7 +167,7 @@
 #define MARK_USED(index, order, area) \
        __change_bit((index) >> (1+(order)),
(area)->map)

-static inline struct page * expand (zone_t *zone,
struct page *page,
+static inline struct page * expand(zone_t *zone,
struct page *page,
         unsigned long index, int low, int high,
free_area_t * area)
 {
        unsigned long size = 1 << high;
@@ -215,7 +215,6 @@
                        zone->free_pages -= 1UL <<
order;

                        page = expand(zone, page,
index, order, curr_order,
area);
-
spin_unlock_irqrestore(&zone->lock, flags);

                        set_page_count(page, 1);
                        if (BAD_RANGE(zone,page))
@@ -224,6 +223,7 @@
                                BUG();
                        if (PageActive(page))
                                BUG();
+
spin_unlock_irqrestore(&zone->lock, flags);
                        return page;
                }
                curr_order++;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
