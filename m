Message-ID: <3BFAB960.DAA72239@mvista.com>
Date: Tue, 20 Nov 2001 12:13:20 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: ppcdevel <linuxppc-dev@lists.linuxppc.org>,
	ppclists <Majordomo@lists.linuxppc.org>
Subject: New API for non cache coherent ppc cpu's
Content-Type: multipart/mixed;
 boundary="------------34518B34C40D548695D3B997"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------34518B34C40D548695D3B997
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



To all NOT_COHERENT_CACHE users

About a month ago a new API made its way into the ppc,
consistent_sync_page.  For CONFIG_NOT_COHERENT_CACHE  processors,
requires
proper flushing of the page being used.  Please review and provide feed
back

-- armin




sample from patch

void consistent_sync_page(struct page *page, unsigned long offset,
size_t size, int direction)
{
        unsigned long start = (unsigned long)page->virtual;
        unsigned long end   = start + size;

        switch (direction) {
        case PCI_DMA_NONE:
                BUG();
        case PCI_DMA_FROMDEVICE:        /* invalidate only */
                invalidate_dcache_range(start, end);
                break;
        case PCI_DMA_TODEVICE:          /* writeback only */
                clean_dcache_range(start, end);
                break;
        case PCI_DMA_BIDIRECTIONAL:     /* writeback and invalidate */
                flush_dcache_range(start, end);
                break;
        }

 }
--------------34518B34C40D548695D3B997
Content-Type: application/octet-stream;
 name="cachemap_1114.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cachemap_1114.patch.gz"

H4sICPC4+jsCA2NhY2hlbWFwXzExMTQucGF0Y2gApVVbT9swFH5OfsWR9hKahPQGG0FM5VKm
SqOdENvTpMjYJ61F6lSOU2Bo/312UtqUpi1oaWVb5/L508k5XxiPY/BlPoSEi/xpNqNRO+pG
DOeYBETSSaBNwXQaUEInOCWzQ1oTadYt0bbv++/Htu5yhGE6h3YTmidh50t41NXnZst2Xfdj
F1ehWs2wfRx2TkqoXg/81lHH+wxuufV6NliUZAg/LgfR1c15NBwN+6E2Whc/vzkHp2/d17ej
m6v+r8FlP7SCBnAxJwlnRCGkInmGRmD7lrWyRqygFUkixuhkikjlAQqmgV3LipM8m+wI0Szu
JZKHDRZ3o1cOhsSj5ArvCX1YctCJNEEidmAXpThue11dCr11OmUtPsTpr+3qv/kFDduFBtBU
ZDxTKFSUPQsazcgYYUoeEAgUZyKxEnQInOmNU5IU6Sp9i+DBfa5AaYRMQ2RK5lSVSFzoKMIg
jbVjzqXKSQKEMYlZZsACQ2ueclZLyqlCNczqQa7DxgIZJKkYa9w4Q+XZbsb/YKTAbJ6+VQHj
EqniqTiw3RdzCyyedYCianAGzpr5wNzlf10QPt2WrGutbWcLELe4vRK8OmWPXNEJOCtS8LLy
1nT20vf6LPq8PqfS7q/++q7fgH3fDLzNWrRWPZll16/ia7t/A3XfLHyMxsXganDbv7wbjIbn
38NNGkS/u0qF6gjtG7K9hMzY6YXt0nAuaJIzDEg29Y1G8vRwsk1I62K36Xdd7KZ6d5t71bsW
6FryAqh1bLS71Vp+Boxgddtdo93lZvQKnxRKAcWcNyqDTpIkpY6Z1nE882BthtmUREYotKEx
0S8rQSNrVaQKUCwRnRJ+bpLWsHbkGaXZmlfqiHzU+f6O/P1KtRSp/0JZ0zut75a1hSzY8Ilh
zAUWRSzbV7e6E5XdGxVFgd+2/Q8zNFkMXQgAAA==
--------------34518B34C40D548695D3B997--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
