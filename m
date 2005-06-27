Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id DB15267A62
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2005 23:59:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 27 Jun 2005 15:59:01 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B3F@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: How to awake a process waiting for a semaphore?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
as the subject of this mpail tells, I'd like to be able to interrupt a =
task that
is waiting for a semaphore to be free.
Indeed I use "down_interruptible()" and I'd like to be able to tell to =
the task
after a period of time : "give up, awake and do something else".
I tried this piece of code in a kernel module to test this, but =
obviously that=20
doesn't work (I tried 2 ways but both failed)  :=20

struct semaphore * testSem;

void myAlert(unsigned long data)
{
  char *msg =3D "TIMEOUT!\n";
  task_t * myTask =3D (task_t *)data;

  printk("Current task state : %d",myTask->state);
  printk("%s",msg);

  // First Test
  wake_up_process((task_t *)data);

  // Second Test
  //myTask->state =3D TASK_RUNNING

int test(void)
{
  int ret_val,state,timeout=3D500;
  struct timer_list myTimer;
  =20
  testSem =3D (struct semaphore *)kmalloc(sizeof(struct =
semaphore),GFP_ATOMIC);
  sema_init(testSem,0);
 =20
  state =3D current->state;
  printk("Current task state: %d\n",state);

  init_timer(&myTimer); =20
  myTimer.expires =3D jiffies + timeout;
  myTimer.data =3D (unsigned long) current;
  myTimer.function =3D myAlert;
  myTimer.data =3D (unsigned long) current;
  add_timer(&myTimer);

  // That will get the task to sleep for sure
  down_interruptible(testSem);

  del_timer_sync(&myTimer);=20
  return 0;
}
