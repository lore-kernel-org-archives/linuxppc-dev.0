Return-Path: <Steffen.Rumler@siemens.com>
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by ozlabs.org (Postfix) with ESMTP id 77BA067A62
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 21:45:22 +1100 (EST)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by david.siemens.de (8.12.6/8.12.6) with ESMTP id j0JAjKkg025333
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jan 2005 11:45:20 +0100
Message-ID: <41EE3A39.7080703@siemens.com>
Date: Wed, 19 Jan 2005 11:45:13 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Dump Page Cache state for out of memory
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

I'm using the following code in order to
dump the state concerning the Page Cache
related to filesystem I/O, from out_of_memory().

Steffen

--

oo_kill.c:

...
typedef struct {
     unsigned long locked;    /* number locked pages */
     unsigned long clean;     /* number clean pages */
     unsigned long dirty;     /* number dirty pages */
     struct super_block *sb;  /* related superblock */
} dump_page_cache_entry_t;

static dump_page_cache_entry_t dump_page_cache_arr[16];

static dump_page_cache_entry_t *
get_dump_cache_entry (struct super_block *sb)
{
     int i;

     for(i=0; i < 16; i++){
         if(dump_page_cache_arr[i].sb == sb)  return &dump_page_cache_arr[i];
         if(dump_page_cache_arr[i].sb == NULL){
             dump_page_cache_arr[i].sb = sb;
             return &dump_page_cache_arr[i];
         }
     }
     return &dump_page_cache_arr[15];
}

/*  dump page cache state
  */

static void dump_page_cache (void)
{
     int i;
     struct page **p = page_hash_table;
     struct page  *q;
     unsigned long flags;
     unsigned long total  = 0;
     dump_page_cache_entry_t *ep;
     struct super_block *sb;

     for(i=0; i<PAGE_HASH_SIZE; i++){

         for(q=*p;q;q=q->next_hash){

             total++;
             if(q->mapping  && q->mapping->host && (sb=q->mapping->host->i_sb)){

                 flags = q->flags;
                 ep = get_dump_cache_entry(sb);

                 if((flags & (1 << PG_locked))){
                     ep->locked++;
                 }else{
                     if((flags & (1 << PG_dirty))){
                         if(flags & (1 << PG_uptodate)){
                             ep->dirty++;
                         }
                     }else{
                         ep->clean++;
                     }
                 }
             }
         }
         p++;
     }

     printk(KERN_EMERG "%s (%d) %s(): Page Cache Status:\n", __FILE__, __LINE__, __func__);
     for(i=0; i<16; i++){

         dump_page_cache_entry_t *ce = &dump_page_cache_arr[i];

         if(ce->sb){

             printk(KERN_EMERG "%14s  clean: %-10d  locked: %-10d  dirty: %d\n",
                     ce->sb->s_type ? ce->sb->s_type->name : "???",
                     ce->clean, ce->locked, ce->dirty);
         }else{
             break;
         }
     }
     printk("%14s %d\n", "total", total);
}

...

void out_of_memory(void)
{
    ...
    dump_page_cache();
    ...
}
